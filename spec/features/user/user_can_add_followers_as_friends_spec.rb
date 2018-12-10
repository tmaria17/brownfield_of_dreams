require 'rails_helper'

describe 'as a user' do
  it 'users can add friends that also have accounts' do
    user_1 = create(:user, token: ENV['github_token'])
    user_2 = create(:user, token: ENV['github_token_2'])
    user_3 = create(:user)


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)


    visit dashboard_path
    save_and_open_page
    expect(page).to have_link("Add Friend")

  end
end
