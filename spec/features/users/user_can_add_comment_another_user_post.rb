require_relative '../../rails_helper'

RSpec.describe "Comment Feature", type: :feature do
  before do
    @user1 = User.create(username: "Chiara", password: "test123")
    @user2 = User.create(username: "Mauro", password: "test123")
    @post2 = @user2.posts.create(message: "Let's go to the beach")
  end

  scenario "User can comment on a post" do
    visit "/"
    click_link "Login"


    # User1 fills in Login Form
    fill_in :username, with: "Chiara"
    fill_in :password, with: "test123"
    click_button "Log In"

    # Check User1 redirected to correct path
    expect(page).to have_current_path("/users/#{@user1.id}")

    # User1 navigates to User2's post
    visit user_path(@user2)
    click_link "Let's go to the beach"
    expect(page).to have_current_path(post_path(@post2))

    # User1 adds a comment to the post
    fill_in "Leave a comment", with: "There is a great beach in Fuerteventura called Playa de Sotavento"
    click_button "Add Comment"

    # Comment appears on the page
    expect(page).to have_content("There is a great beach in Fuerteventura called Playa de Sotavento")
    within("#single-comment") do
      expect(page).to have_content("There is a great beach in Fuerteventura called Playa de Sotavento")
      expect(page).to have_content("From - Chiara")
    end
  end
end
