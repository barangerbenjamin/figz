class FetchAndParseGpx
  def initialize(key)
    @key = key
    @gsp_name = ""
  end

  def fetch_gpx
    storage = Google::Cloud::Storage.new(
      project_id: "figz-app",
      credentials: Rails.root.join("config/secrets/figz_google_bucket.json")
    )
    bucket = storage.bucket "figz"
    file = bucket.file @key
    file.download "tmp/#{@key}.gpx"
  end

  def parse_gpx
    doc = Nokogiri::XML(open("tmp/#{@key}.gpx"))
    trackpoints = doc.xpath('//xmlns:trkpt')
    points = trackpoints.map do |trkpt|
      [trkpt.xpath('@lat').to_s.to_f, trkpt.xpath('@lon').to_s.to_f]
    end
    return points
  end

  def parse_elevation
    doc = Nokogiri::XML(open("tmp/#{@key}.gpx"))
    elevation = {}
    data = doc.xpath('//xmlns:ele')
    data.each_with_index do |trkpt, index|
      completion = (index * 100 / data.size.to_f).round(2)
      if index = 0 || index % 100 == 0
        if completion.to_i == completion
          elevation["#{completion}%"] = trkpt.text.to_f
        end
      end
    end
    return elevation
  end

  def parse_name
    doc = Nokogiri::XML(open("tmp/#{@key}.gpx"))
    trackpoints = doc.xpath('//xmlns:name')
    trackpoints.each do |trkpt|
     return trkpt.text.to_s
    end
  end
end