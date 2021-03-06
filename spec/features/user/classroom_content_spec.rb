require 'rails_helper'

describe 'as a user' do
  it 'displays content marked classroom content to logged in users' do
    user = create(:user, token: ENV['github_token_2'])
    tutorial = create(:tutorial, classroom: true)
    video1 = create(:video, tutorial_id: tutorial.id)
    video2 = create(:video, tutorial_id: tutorial.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorials_path

    expect(page).to have_content(tutorial.title)

    visit tutorial_path(tutorial)

    expect(page).to have_content(tutorial.title)
  end

  it 'does not display classroom content to users not logged in'do
    user = create(:user)
    tutorial = create(:tutorial, classroom: true)
    video1 = create(:video, tutorial_id: tutorial.id)
    video2 = create(:video, tutorial_id: tutorial.id)
    tutorial_2 = create(:tutorial, classroom: false)
    video3 = create(:video, tutorial_id: tutorial_2.id)
    video4 = create(:video, tutorial_id: tutorial_2.id)

    visit tutorials_path

    expect(page).to_not have_content(tutorial.title)
    expect(page).to have_content(tutorial_2.title)

    visit tutorial_path(tutorial)
    expect(page).to_not have_content(tutorial.title)
    expect(page).to have_content("Please log in to view this tutorial.")

    visit tutorial_path(tutorial_2)
    expect(page).to have_content(tutorial_2.title)
  end
end
