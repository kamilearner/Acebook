# --- login helper function
module LoginHelper
  def login_as(user)
    visit "/"
    click_link "Login"
    fill_in :username, with: user.username
    fill_in :password, with: user.password
    click_button "Log In"
  end
end

RSpec.configure do |config|
  config.include LoginHelper, type: :feature
end