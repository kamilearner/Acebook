require_relative '../../rails_helper'

# ------------- REGISTER
RSpec.describe "User can register", type: :feature do

  # Create TEST DATABASE with current users
  before do
    @user1 = User.create(username: "Kamilya", password: "test123")
    @user2 = User.create(username: "Khari", password: "test123")
    @user3 = User.create(username: "Chiara", password: "test123")
    @user4 = User.create(username: "Mauro", password: "test123")
  end
  
  scenario "User registers and redirected to user's homepage" do
    visit "/"
    click_link "Register"


    # New User fills in Register Form
    fill_in :username, with: "Poppy"
    fill_in :password, with: "test1234"
    click_button "Register"


    # Create New User
    @user = User.create(username: "Poppy", password: "test1234")

    
    # Check New User is redirected to correct path -- 5, because 5th user added to test database
    expect(page).to have_current_path("/users/5")

    # Checks New User's name is present
    expect(page).to have_text("Hi Poppy !")

    # Check Other Links are present -- "Add a New post", "Log Out", "My Friends"
    expect(page).to have_link("Add a New post", href: new_post_path)
    expect(page).to have_link("Log Out", href: logout_path)
    expect(page).to have_link("My Friends", href: friends_path)

  end
end