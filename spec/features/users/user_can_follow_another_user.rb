require_relative '../../rails_helper'

# ------------- FOLLOW FEATURE
RSpec.describe "User Can Follow User", type: :feature do
  

  # Create TEST DATABASE with current users & their respective posts
  before do
    # user logged in
    @user1 = User.create(username: "Chiara", password: "test123")
    @post1 = @user1.posts.create(message: "I need a nap")

    # post to interact with
    @user2 = User.create(username: "Mauro", password: "test123")
    @post2 = @user2.posts.create(message: "Let's go to the beach")
    @post3 = @user2.posts.create(message: "Working from home")
  end

  scenario "User can login and follow user" do
    visit "/"
    click_link "Login"


    # User1 fills in Login Form
    fill_in :username, with: "Chiara"
    fill_in :password, with: "test123"
    click_button "Log In"


    # Check User1 redirected to correct path
    expect(page).to have_current_path("/users/#{@user1.id}")

    # Check User1's name is present
    expect(page).to have_text("Hi Chiara !")

    # Check User1's posts are present with links - "Edit", "Delete"
    expect(page).to have_text("I need a nap")
    expect(page).to have_link("Edit", href: edit_post_path(@post1))
    expect(page).to have_link("Delete", href: post_path(@post1))

    # Check Other Links are present -- "Add a New post", "Log Out", "My Friends"
    expect(page).to have_link("Add a New post", href: new_post_path)
    expect(page).to have_link("Log Out", href: logout_path)
    expect(page).to have_link("My Friends", href: friends_path)

    # User1 clicks "My Friends" link
    click_link "My Friends"

    # Page redirects to friends page
    expect(page).to have_current_path(friends_path)

    # ---------------------------------- FOLLOW FEATURE ---------------------------------------
    # User1 can view option to follow User2
    expect(page).to have_text("People you might know")
    expect(page).to have_link("Mauro")
    expect(page).to have_button("Follow")

    # User1 follows User2
    click_button "Follow"

    # User1 can now view User2 as someone they follow
    expect(page).to have_text("People you follow")
    expect(page).to have_link("Mauro")
    expect(page).to have_button("Unfollow")

    # User1 clicks button to view User2's profile
    click_link "Mauro"

    # Page redirects to User2's homepage
    expect(page).to have_current_path("/users/#{@user2.id}")
    
    # User1 can view User2 posts
    expect(page).to have_text("Welcome to Mauro's page")
    expect(page).to have_link("Let's go to the beach", href: post_path(@post2))
    expect(page).to have_link("Working from home", href: post_path(@post3))

    # User1 clicks link to view post1
    click_link "Let's go to the beach"

    # Page redirects to post2's page
    expect(page).to have_current_path("/posts/#{@post2.id}")

  end
end