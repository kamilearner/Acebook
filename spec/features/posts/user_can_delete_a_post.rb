require_relative '../../rails_helper'

RSpec.describe "Delete Post", type: :feature do
  
  # Create TEST DATABASE
  before do
    @user = User.create(username: "Khari", password: "test123")
    @post1 = @user.posts.create(message: "Flats in South London are the most affordable")
    @post2 = @user.posts.create(message: "What a beautiful country Fuerteventura is")
  end

  # View Post
  scenario "User can view a post" do
    visit "/"
    click_link "Login"

    # Fill in Login Form
    fill_in :username, with: "Khari"
    fill_in :password, with: "test123"
    click_button "Log In"

    # Check User redirected to correct path
    expect(page).to have_current_path("/users/#{@user.id}")
    expect(page).to have_text("Hi Khari !")

    # Check User's posts are present with link - "Delete", redirects & deletes
    expect(page).to have_text("Flats in South London are the most affordable")
    expect(page).to have_link("Delete", href: post_path(@post1))
    click_link "Delete", href: post_path(@post1)

    # Expectations for successful deletion
    expect(page).to have_content("What a beautiful country Fuerteventura is")
    expect(Post.last.message).to eq("What a beautiful country Fuerteventura is")
  end
end