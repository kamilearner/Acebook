require_relative '../../rails_helper'

# ------------- USER INTERACTIONS WITH A POST - follows user, view profile, like/dislike a post, add comment
RSpec.describe "User can interact with post", type: :feature do
  

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

  scenario "User can login, follow another user, like & comment on their post" do
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


    # --------------------------------- LIKE FEATURE ---------------------------------------------
    expect(page).to have_text("Let's go to the beach")

    # no likes
    expect(page).to have_content("0 Likes")

    # user likes post, updates counter
    expect(page).to have_button("Like")
    click_button "Like"
    expect(page).to have_content("1 Likes")

    # user unlikes post, updates counter
    expect(page).to have_button("Unlike")
    click_button "Unlike"
    expect(page).to have_content("0 Likes")


    # --------------------------------- COMMENT FEATURE -------------------------------------------
    expect(page).to have_selector("#comment-form")

    # fill comment, display on post page
    fill_in "Leave a comment", with: "There is a great beach in Fuerteventura called Playa de Sotavento"

    # submit comment, shows on post2 page
    click_button "Add Comment"
    expect(page).to have_content("There is a great beach in Fuerteventura called Playa de Sotavento")

    # verify comments appears
    within("#single-comment") do
      expect(page).to have_content("There is a great beach in Fuerteventura called Playa de Sotavento")
      expect(page).to have_content("From - Chiara")
    end

  end
end