require 'rails_helper'

describe 'as a guest user' do

  before(:each) do
    @email = 'jimbob@aol.com'
    @first_name = 'Jim'
    @last_name = 'Bob'
    @password = 'password'
    @password_confirmation = 'password'
  end

  it 'I can activate my account with an email' do

    visit '/'
    click_on "Register"

    expect(current_path).to eq("/register")

    fill_in "Email", with: @email
    fill_in "First name", with: @first_name
    fill_in "Last name", with: @last_name
    fill_in "Password", with: @password
    fill_in "Password confirmation", with: @password_confirmation

    click_on "Create Account"

    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("Logged in as #{@first_name} #{@last_name}")
    expect(page).to have_content("This account has not yet been activated. Please check your email.")
  end
end
