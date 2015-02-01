require 'open-uri'

class OmdbServices

  # connect with omdbapi and search for a movies with given title,
  # then return nested hash with results.
  def search(title)
    url =  "http://www.omdbapi.com/?s=#{title}&r=json"
    return_result(url)
  end

  def get_info(id)
    url = "http://www.omdbapi.com/?i=#{id}&y=&plot=short&r=json"
    return_result(url)
  end

  private 

  # Open given url and convert Json string to hash.
  def return_result(url)
    json_file = open(url) { |f| f.read }
    JSON.parse(json_file)
  end
end
