require 'rails_helper'

describe 'A registered user' do

  it 'can display repo index if user has a token' do
    VCR.use_cassette("github_token") do

    user = create(:user, token: ENV['github_token'], github_id: 123456)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to_not have_content("Connect to Github")
      expect(page).to have_css(".repo", count: 5)

      within(first(".repo")) do
        expect(page).to have_css(".name")
      end
    end
  end

  it 'does not see a github section if they dont have a token' do

    VCR.use_cassette("github_1") do

    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/dashboard'
    expect(page).to have_content("Connect to Github")
  end

  end

  it "displays the correct repos when there is more than one user" do
    VCR.use_cassette("github_token") do

    user_1 = create(:user, token: ENV['github_token'], github_id: 123456)
    user_2 = create(:user, token: ENV['github_token_2'], github_id: 1233456)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
      visit '/dashboard'


      expect(page).to have_content("battleshift")
      expect(page).to_not have_content("bradley_cooper")
    end
  end
end
