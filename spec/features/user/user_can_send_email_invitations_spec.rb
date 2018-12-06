require 'rails_helper'

describe 'as a registered user' do
  xit 'I can click on a link and go to /invite' do
    user = create(:user, token: ENV['github_token'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    click_on("Send an Invite")
    save_and_open_page
    expect(current_path).to eq(invite_path)
  end

  xit 'can send invites by github handle' do
    user_1 = create(:user, token: ENV['github_token_2'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit invite_path

    fill_in "Github handle", with: "mstang15"

    click_on "Send Invite"


    expect(current_path).to eq(dashboard_path)
  end
end
