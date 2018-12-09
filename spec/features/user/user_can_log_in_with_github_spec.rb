require 'rails_helper'


describe 'test user' do
  it 'can log in with github' do
    stub_omniauth
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path
    click_on "Connect to Github"

    expect(user.token).to eq("token #{ENV['github_token']}")
    expect(page).to have_content("Followers")
    expect(page).to have_content("Following")
    expect(page).to_not have_content("Connect to Github")
  end
end

def stub_omniauth
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({'credentials' => {'token' => ENV['github_token']}})
end
