require 'rails_helper'

describe "as a user " do
  it 'displays new video if tutorial has no videos' do
    tutorial = create(:tutorial)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    expect(page).to have_content("This tutorial has no videos!")
    expect(current_path).to eq(dashboard_path)
  end
end
