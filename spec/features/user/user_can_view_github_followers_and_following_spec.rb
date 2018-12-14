require 'rails_helper'

describe 'A registered user' do

  it 'displays github followers' do
    VCR.use_cassette("github_followers") do

    user = create(:user, token: ENV['github_token'], github_id: 123456)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'
    end

      expect(page).to have_content("Github")
      expect(page).to have_content("Followers")
      expect(page).to have_css(".follower")
      within(first(".follower")) do
        expect(page).to have_css(".name")
      end
  end

  it 'displays github followed users' do
    VCR.use_cassette("github_following") do

    user = create(:user, token: ENV['github_token'], github_id: 123456)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)


      visit '/dashboard'
    end
      expect(page).to have_content("Github")
      expect(page).to have_content("Following")
      expect(page).to have_css(".followed_user")
      within(first(".followed_user")) do
        expect(page).to have_css(".name")
      end
  end

end
