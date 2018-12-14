require "rails_helper"

describe 'as a user' do
  it 'emails invitations using github handles' do
    user = create(:user, token: ENV['github_token'], github_id: 123456)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette("github_invites") do
      visit "/dashboard"
      click_on "Send an Invite"

      expect(current_path).to eq("/invite")

      fill_in :github_handle, with: "jplao"
      click_on "Send Invite"

      expect(current_path).to eq("/dashboard")
      expect(page).to have_content("Successfully sent invite!")
    end
  end

  it 'displays an error if the user does not have a public email' do
    user = create(:user, token: ENV['github_token'], github_id: 123456)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette("github_invites_two") do
      visit "/dashboard"
      click_on "Send an Invite"

      expect(current_path).to eq("/invite")

      fill_in :github_handle, with: "tmaria17"
      click_on "Send Invite"

      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
      expect(current_path).to eq("/dashboard")
    end
  end
end
