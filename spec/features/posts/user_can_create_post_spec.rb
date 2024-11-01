require_relative '../../rails_helper'

RSpec.describe "Create Post Feature", type: :feature do

  # Create TEST DATABASE
  before do
    @user = User.create(username: "Mauro", password: "test123")
  end

  # Create Post
  scenario "User can create a new post" do
    visit "/"
    click_link "Login"

    # Fill in Login Form
    fill_in :username, with: "Mauro"
    fill_in :password, with: "test123"
    click_button "Log In"

    # Check User redirected to correct path
    expect(page).to have_current_path("/users/#{@user.id}")
    expect(page).to have_text("Hi Mauro !")

    # User clicks link, redirects to create new post
    expect(page).to have_link("Add a New post", href: new_post_path)
    click_link "Add a New post"
    expect(page).to have_current_path("/posts/new")

    # User fills in message, uploads a picture, submits, then redirects
    fill_in "post[message]", with: "This is a real journey"
    attach_file "post[image]", Rails.root.join('spec', 'fixtures', 'journey.jpg')
    click_button "Submit Post"

    # Expectations for a successful post creation
    expect(page).to have_content("This is a real journey")
    expect(Post.last.message).to eq("This is a real journey")
    expect(Post.last.image).to be_present
  end
end