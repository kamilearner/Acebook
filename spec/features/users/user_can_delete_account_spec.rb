require_relative '../../rails_helper'

# ------------ DELETE USER ACCOUNT
RSpec.describe "User can delete account", type: :feature do
  
  # Create TEST DATABASE with current users 
  before do
    @user1 = User.create(username: "Kamilya", password: "test123")
    @user2 = User.create(username: "Khari", password: "test123")
  end

  scenario "Logged In User deletes their account then redirected to website's homepage" do
    visit "/"
    click_link "Login"

    # User logs in
    fill_in :username, with: "Khari"
    fill_in :password, with: "test123"
    click_button "Log In"


    # Check User redirected to correct path
    expect(page).to have_current_path("/users/2")

    # Checks User's name is present
    expect(page).to have_text("Hi Khari !")

    # Check "Delete Account" button is present
    expect(page).to have_button("Delete Account")

    # User clicks "Delete Account" button
    click_button "Delete Account"

    # After deletion, redirects to website's homepage
    expect(page).to have_current_path(root_path)

    # Checks Homepage has links to "Register" & Login
    expect(page).to have_link("Login", href: login_path)
    expect(page).to have_link("Register", href: register_path)

  end
end