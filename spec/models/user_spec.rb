require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(username: "test name", password: "test123")
    expect(user).to be_valid
  end

  it "is not valid without a username" do
    expect(User.new(username: nil, password: "test")).to_not be_valid
  end

  it "is not valid without a password" do
    expect(User.new(username:'test', password: nil)).to_not be_valid
  end
end
