require 'rails_helper'

describe 'as a user' do
  it 'users have add friend link next to other github users' do
    VCR.use_cassette("github_friends_2") do

    user_1 = create(:user, token: ENV['github_token'], github_id: 123456)
    user_2 = create(:user, token: ENV['github_token_2'], github_id: 37811063)
    user_3 = create(:user)


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit dashboard_path
  end
    within('.followers') do
      expect(page).to have_link("Add Friend")
    end
  end

  it 'users can use add friend link to actually add friends' do
    VCR.use_cassette("github_friends") do

    user_1 = create(:user, token: ENV['github_token'], github_id: 12345678)
    user_2 = create(:user, token: ENV['github_token_2'], github_id: 37811063)
    user_3 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
      visit dashboard_path
      within('.followers') do
        click_on "Add Friend"
     end

     within('.friends') do
       expect(page).to have_content(user_2.first_name)
       expect(page).to have_content(user_2.last_name)
       expect(page).to_not have_content(user_3.first_name)
     end

     within('.followers') do
       expect(page).to_not have_content("Add Friend")
     end

     expect(page).to have_content("You have added #{user_2.first_name} #{user_2.last_name} as a friend.")
  end
end

  it 'does not add friends without valid id' do
    VCR.use_cassette("invalid_github_friends") do

    user_1 = create(:user, token: ENV['github_token'], github_id: 12345678)
    user_2 = create(:user, token: ENV['github_token_2'], github_id: 37811063)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit friendship_path(36902512)
      expect(page).to have_content("This friendship could not be created.")

      visit friendship_path(37811063)
      expect(page).to_not have_content("This friendship could not be created.")
    end
  end


end
