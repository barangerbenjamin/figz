class FetchAndParseGpx
  def initialize(key)
    @key = key
  end

  def fetch_gpx
    url = "http://res.cloudinary.com/bbaranger/image/upload/{@key}"
  end

end