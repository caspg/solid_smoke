require 'open-uri'

class OmdbServices
  # If params are given:
  # connect with omdbapi and fetch needed data.

  # Return nested hash with results.
  def search(title)
      url =  "http://www.omdbapi.com/?s=#{clean_title(title)}&r=json"
      return_result(url)
  end

  # Return hash with movie informations.
  def get_info(id)
    url = "http://www.omdbapi.com/?i=#{id}&y=&plot=short&r=json"
    return_result(url)
  end

  private

  def clean_title(title)
    # Strip spaces. And convert inside spaces into '+'.
    title.strip.gsub(/[[:space:]]/, '+')
  end

  # Open given url and convert Json string to hash.
  def return_result(url)
    json_file = open(url) { |f| f.read }
    JSON.parse(json_file)
  end
end
