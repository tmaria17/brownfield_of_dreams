require 'rails_helper'

describe 'A registered user' do
  it 'can display repo index' do
    user = create(:user)
    binding.pry

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/dashboard'
    save_and_open_page
    expect(page).to have_content("Github")
    expect(page).to have_css(".repo", count: 5)

    within(first(".repo")) do
      expect(page).to have_css(".name")
    end
  end
end
