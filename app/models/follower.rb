class Follower
  attr_reader :name,
              :url,
              :github_id

  def initialize(data)
    @name = data[:login]
    @url = data[:html_url]
    @github_id = data[:id]
  end
end
