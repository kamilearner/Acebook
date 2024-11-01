require_relative '../../rails_helper'

# ------------- LIKE FEATURE
RSpec.describe "User can like/dislike a post", type: :feature do
  

  # Create TEST DATABASE with current users & their respective posts
  before do
    # user logged in
    @user1 = User.create(username: "Chiara", password: "test123")

    # post to interact with
    @user2 = User.create(username: "Mauro", password: "test123")
    @post2 = @user2.posts.create(message: "Let's go to the beach")
  end

  scenario "User can like and unlike another users's post" do
    visit "/"
    click_link "Login"


    # User1 fills in Login Form
    fill_in :username, with: "Chiara"
    fill_in :password, with: "test123"
    click_button "Log In"


    # Check User1 redirected to correct path
    expect(page).to have_current_path("/users/#{@user1.id}")


    # User1 navigates to User2's page
    click_link "My Friends"
    expect(page).to have_link("Mauro")
    click_link "Mauro"
    expect(page).to have_current_path("/users/#{@user2.id}") 
    click_link "Let's go to the beach"
    expect(page).to have_current_path("/posts/#{@post2.id}")


    # --------------------------------- LIKE FEATURE ---------------------------------------------
    
    # no likes
    expect(page).to have_text("Let's go to the beach")
    expect(page).to have_content("0 Likes")

    # User1 likes post, updates counter
    expect(page).to have_button("Like")
    click_button "Like"
    expect(page).to have_content("1 Likes")

    # User1 unlikes post, updates counter
    expect(page).to have_button("Unlike")
    click_button "Unlike"
    expect(page).to have_content("0 Likes")
  
  end
end