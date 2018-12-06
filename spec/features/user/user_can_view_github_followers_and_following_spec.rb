require 'rails_helper'

describe 'A registered user' do

  it 'displays github followers' do
    user = create(:user, token: ENV['github_token'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette("github_followers") do
      visit '/dashboard'

      expect(page).to have_content("Github")
      expect(page).to have_content("Followers")
      expect(page).to have_css(".follower")
      within(first(".follower")) do
        expect(page).to have_css(".name")
      end
    end
  end

  it 'displays github followed users' do
    user = create(:user, token: ENV['github_token'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette("github_following") do

      visit '/dashboard'
      expect(page).to have_content("Github")
      expect(page).to have_content("Following")
      expect(page).to have_css(".followed_user")
      within(first(".followed_user")) do
        expect(page).to have_css(".name")
      end
    end
  end

end
