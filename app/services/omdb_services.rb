require 'open-uri'

class OmdbServices
  # If params are given:
  # connect with omdbapi and fetch needed data or rescue with flash message.

  # Return nested hash with results.
  def search(title)
    begin
      # Strip spaces. And convert inside spaces into '+'.
      clean_title = title.strip.gsub(/[[:space:]]/, '+')
      url =  "http://www.omdbapi.com/?s=#{clean_title}&r=json"
      return_result(url)
    rescue
        flash[:danger] = "Couldn't fetch data! Try later or add movie informations manually."
      end
  end

  # Return hash with movie informations.
  def get_info(id)
    begin
      url = "http://www.omdbapi.com/?i=#{id}&y=&plot=short&r=json"
      @movie_info = return_result(url)
    rescue
        flash[:danger] = "Couldn't fetch data! Try later or add movie informations manually."
      end
  end

  private 

  # Open given url and convert Json string to hash.
  def return_result(url)
    json_file = open(url) { |f| f.read }
    JSON.parse(json_file)
  end
end
