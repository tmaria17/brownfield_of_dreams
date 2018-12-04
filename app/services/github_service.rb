class GithubService
  # def initialize(filter)
  #   @filter = find_username
  # end

  def get_repos(username)
    get_json("/users/#{username}/repos")
  end

private

  def conn
    url = "https://api.github.com"
    Faraday.new(url: url) do |faraday|
        faraday.adapter Faraday.default_adapter
        faraday.params["access_token"] = ENV['github_token']
    end
  end

  def get_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
    binding.pry
  end

end
