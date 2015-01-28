require 'open-uri'

class OmdbServices

  # connect with omdbapi and search for a movies with given title,
  # then return nested hash with results.
  def search(title)
    url =  "http://www.omdbapi.com/?s=#{title}&r=json"
    json_file = open(url) { |f| f.read }
    result_hash = JSON.parse(json_file)
  end

  def get_info(title)
    utl = "http://www.omdbapi.com/?t=#{title}&y=&plot=full&r=json"
    json_file = open(utl) { |f| f.read }
    result_hash = JSON.parse(json_file)
  end

end
