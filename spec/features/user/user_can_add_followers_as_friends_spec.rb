require 'rails_helper'

describe 'as a user' do
  it 'users have add friend link next to other github users' do
    user_1 = create(:user, token: ENV['github_token'])
    user_2 = create(:user, token: ENV['github_token_2'], github_id: 37811063)
    user_3 = create(:user)


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)


    visit dashboard_path

    expect(page).to have_link("Add Friend")
  end

  it 'users can use add friend link to actually add friends' do
    user_1 = create(:user, token: ENV['github_token'], github_id: 12345678)
    user_2 = create(:user, token: ENV['github_token_2'], github_id: 37811063)
    user_3 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit dashboard_path

    click_on "Add Friend"
    save_and_open_page
    within('.friends') do
      expect(page).to have_content(user_2.first_name)
      expect(page).to have_content(user_2.last_name)
      expect(page).to_not have_content(user_3.first_name)
    end
  end
end
