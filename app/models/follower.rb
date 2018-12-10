class Follower
  attr_reader :name,
              :url,
              :github_id

  def initialize(data)
    @name = data[:login]
    @url = data[:html_url]
    @github_id = data[:id]
  end

  def conn
    url = "https://api.github.com"
    Faraday.new(url: url) do |faraday|
        faraday.adapter Faraday.default_adapter
        faraday.headers["Authorization"] = @token
    end
  end

  def get_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end


end
