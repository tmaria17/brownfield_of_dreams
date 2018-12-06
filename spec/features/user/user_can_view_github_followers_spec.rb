require 'rails_helper'

describe 'A registered user' do

  it 'displays github followers' do
    user = create(:user, token: ENV['github_token'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/dashboard'
    save_and_open_page
    expect(page).to have_content("Github")
    expect(page).to have_content("Followers")
    expect(page).to have_css(".follower")
    within(first(".follower")) do
      expect(page).to have_css(".name")
    end
  end
end
