require 'rails_helper'

describe 'as a registered user' do
  it 'users can see bookmarked videos' do
    video_1 = create(:video)
    video_2 = create(:video)
    video_3 = create(:video)
    video_4 = create(:video)

    user = create(:user, token: ENV['github_token'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_content("Bookmarked")
    expect(page)

  end
end
