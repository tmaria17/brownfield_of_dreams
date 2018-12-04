class Repo
  attr_reader :name

  def initialize(data)
    @name = data[:name]
    @url = data[:html_url]
  end


end
