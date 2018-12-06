require 'rails_helper'

describe 'as a registered user' do
  it 'my dashboard has a list of my followers linked to their repo' do
    user = create(:user, token: ENV['github_token'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'
    
    expect(page).to have_content("Followers")
    expect(page).to have_link("andrewetobin")
  end

end
