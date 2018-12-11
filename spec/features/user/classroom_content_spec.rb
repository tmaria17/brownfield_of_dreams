require 'rails_helper'

describe 'as a logged in user' do
  it 'displays content marked classroom content' do
    user = create(:user, token: ENV['github_token_2'])
    tutorial = create(:tutorial, classroom: true)
    video1 = create(:video, tutorial_id: tutorial.id)
    video2 = create(:video, tutorial_id: tutorial.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    expect(page).to have_content(tutorial.title)
  end
end
