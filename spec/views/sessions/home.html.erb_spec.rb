require 'rails_helper'
# require_relative "../../rails_helper"

RSpec.describe "sessions/home.html.erb", type: :view do
    it "displays the welcome message" do
        render 
        expect(rendered).to have_selector("h1", text: "Welcome to Acebook")
    end 
    
    it"has a link to login path" do 
        render 
        expect(rendered).to have_link("Login",  href: login_path)
    end

    it"has a link to register path" do 
        render 
        expect(rendered).to have_link("Register",  href: register_path)
    end
end