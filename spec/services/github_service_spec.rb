require 'rails_helper'

describe GithubService do
  before(:each) do
    @service = GithubService.new(ENV['github_token_2'])
  end
  it 'exists' do
      expect(@service).to be_a(GithubService)
  end

  it 'gets repos' do
      repos = @service.get_repos

      expect(repos).to be_a(Array)
      expect(repos.count).to eq(5)
      expect(repos.first).to be_a(Hash)
  end

  it 'gets followers' do
      followers = @service.get_followers

      expect(followers).to be_a(Array)
      expect(followers.first).to be_a(Hash)
  end
end
