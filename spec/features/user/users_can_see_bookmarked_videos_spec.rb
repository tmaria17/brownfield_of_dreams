require 'rails_helper'

describe 'as a registered user' do
  it 'users can see bookmarked videos' do
    video_1 = create(:video)
    video_2 = create(:video)
    video_3 = create(:video)
    video_4 = create(:video)

    user = create(:user, token: ENV['github_token'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(id: video_1.tutorial_id, video_id: video_1.id)
    click_on "Bookmark"

    visit tutorial_path(id: video_2.tutorial_id, video_id: video_2.id)
    click_on "Bookmark"

    visit dashboard_path

    within('.bookmarked') do
      expect(page).to have_content("Bookmarked Segments")
      expect(page).to have_content(video_1.title)
      expect(page).to have_content(video_2.title)
      expect(page).to_not have_content(video_3.title)
    end

  end
end
