require_relative '../../rails_helper'

# ----------- LOGIN FEATURE 
RSpec.describe "User can log in", type: :feature do

  # Create USER & POSTS using Test Database
  before do
    @user = User.create(username: "Khari", password: "test123")
    @post1 = @user.posts.create(message: "Coming back from holiday")
    @post2 = @user.posts.create(message: "Can't wait to go on holiday")
  end

  scenario "User can login and view all their posts" do
    visit "/"
    click_link "Login"


    # Fill in Login Form
    fill_in :username, with: "Khari"
    fill_in :password, with: "test123"
    click_button "Log In"


    # Check User redirected to correct path
    expect(page).to have_current_path("/users/#{@user.id}")

    
    # Checks User's name is present
    expect(page).to have_text("Hi Khari !")

    # Check User's posts are present
    expect(page).to have_text("Coming back from holiday")
    expect(page).to have_text("Can't wait to go on holiday")


    # Check User's posts have links present - "Edit", "Delete"
    expect(page).to have_link("Edit", href: edit_post_path(@post1))
    expect(page).to have_link("Delete", href: post_path(@post1))

    expect(page).to have_link("Edit", href: edit_post_path(@post2))
    expect(page).to have_link("Delete", href: post_path(@post2))


    # Check Other Links are present -- "Add a New post", "Log Out", "My Friends"
    expect(page).to have_link("Add a New post", href: new_post_path)
    expect(page).to have_link("Log Out", href: logout_path)
    expect(page).to have_link("My Friends", href: friends_path)

  end
end
