require 'rails_helper'

feature "An admin visiting the admin dashboard" do
  scenario "can see all tutorials" do
    admin = create(:admin)
    create_list(:tutorial, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    expect(page).to have_css(".admin-tutorial-card", count: 2)
  end

  it 'can create a new tutorial' do
    admin = create(:admin)
    create_list(:tutorial, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit "/admin/dashboard"
    click_on "New Tutorial"
    expect(current_path).to eq(new_admin_tutorial_path)

  end
end
