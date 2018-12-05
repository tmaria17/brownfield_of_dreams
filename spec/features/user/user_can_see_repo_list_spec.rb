require 'rails_helper'

describe 'A registered user' do
  it 'can display repo index if user has a token' do
    user = create(:user, token: "123fad")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/dashboard'

    expect(page).to have_content("Github")
    expect(page).to have_css(".repo", count: 5)

    within(first(".repo")) do
      expect(page).to have_css(".name")
    end
  end

  xit 'does not see a github section if they dont have a token' do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/dashboard'


  end
end
