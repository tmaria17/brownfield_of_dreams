require 'rails_helper'

describe 'A registered user' do

  it 'can display repo index if user has a token' do
    user = create(:user, token: ENV['github_token'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette("github_token") do
      visit '/dashboard'

      expect(page).to have_content("Github")
      expect(page).to have_css(".repo", count: 5)

      within(first(".repo")) do
        expect(page).to have_css(".name")
      end
    end
  end

  it 'does not see a github section if they dont have a token' do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/dashboard'

    expect(page).to_not have_content("Github")
  end

  it "displays the correct repos when there is more than one user" do
    user_1 = create(:user, token: ENV['github_token'])
    user_2 = create(:user, token: ENV['github_token_2'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    VCR.use_cassette("github_token") do
      visit '/dashboard'

      expect(page).to have_content("battleshift")
      expect(page).to_not have_content("bradley_cooper")
    end
  end
end
