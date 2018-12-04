class GithubService

  def get_repos
    get_json("/user/repos?per_page=5")
  end

private

  def conn
    url = "https://api.github.com"
    Faraday.new(url: url) do |faraday|
        faraday.adapter Faraday.default_adapter
        faraday.headers["Authorization"] = ENV['github_token']
    end
  end

  def get_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end

end
