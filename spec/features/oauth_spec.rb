require 'rails_helper'

  context 'as a signed in user' do
    it 'connects to github' do
      def stub_omniauth
        OmniAuth.config.test_mode = true
        OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({'credentials' =>{'token' =>  ENV['github_token']},'extra'=>{'raw_info'=> {'id'=> 123456}}})
      end

      stub_omniauth
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'
      click_link "Connect to Github"

      expect(user.token).to eq(ENV['github_token'])
      expect(page).to have_content("Following")
      expect(page).to have_content("Followers")
      expect(page).to_not have_content("Connect to Github")
    end
  end
