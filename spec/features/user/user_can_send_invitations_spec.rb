require "rails_helper"

describe 'as a user' do
  it 'emails invitations using github handles' do
    user = create(:user, token: ENV['github_token'], github_id: 123456)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"
    click_on "Send an Invite"

    expect(current_path).to eq("/invite")
    fill_in "Github Handle", with: "mstang15"
    click_on "Send Invite"
    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("Successfully sent invite!")
    # if the user has an email address associated with their github account
    #"The Github user you selected doesn't have an email address associated with their account."
  end
end
