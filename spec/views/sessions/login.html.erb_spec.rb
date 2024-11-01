require 'rails_helper'
# require_relative "../../rails_helper"

RSpec.describe "sessions/login.html.erb", type: :view do
    it "displays the login message" do
        render 
        expect(rendered).to have_selector("h1", text: "Log In to Acebook")
    end 

    it "displays the login form with the correct fields" do
        render 
        expect(rendered).to have_selector("form[action='/login'][method='post']")
        expect(rendered).to have_selector("input[name='username'][type='text']")
        expect(rendered).to have_selector("input[name='password'][type='password']")
        expect(rendered).to have_selector("input[type='submit'][value='Log In']")
        
    end 
end


