require_relative '../../rails_helper'

RSpec.describe "Read and Update Post", type: :feature do
  
  # Create TEST DATABASE
  before do
    @user = User.create(username: "Kamilya", password: "test123")
    @post = @user.posts.create(message: "What a beautiful country Fuerteventura is")
  end

  # View Post
  scenario "User can view a post" do
    visit "/"
    click_link "Login"

    # Fill in Login Form
    fill_in :username, with: "Kamilya"
    fill_in :password, with: "test123"
    click_button "Log In"

    # Check User redirected to correct path
    expect(page).to have_current_path("/users/#{@user.id}")
    expect(page).to have_text("Hi Kamilya !")

    # Check User's posts are present with link - "Edit", redirects & updates
    expect(page).to have_text("What a beautiful country Fuerteventura is")
    expect(page).to have_link("Edit", href: edit_post_path(@post))
    click_link "Edit"

    # -------------------- READ POST
    expect(page).to have_current_path("/posts/#{@post.id}/edit")

    # --------------------- UPDATE POST
    fill_in "post[message]", with: "What a beautiful country Jamaica is"
    click_button "Update post"

    # Expectations for successful update
    expect(page).to have_content("What a beautiful country Jamaica is")
    expect(Post.last.message).to eq("What a beautiful country Jamaica is")
  end
end