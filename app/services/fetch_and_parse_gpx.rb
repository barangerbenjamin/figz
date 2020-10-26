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
end