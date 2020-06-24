require 'rails_helper'

RSpec.describe User, type: :model do

  context "is not saved" do

    it "with invalid email" do
      user = build(:user, email: "userexample.com" )
      expect(user.save).to be false
    end

    it "when the email already exists" do
      user1 = build(:user)
      user1.save
      user2 = build(:user)
      expect(user2.save).to be false
    end

    it "when first and last names are empty" do
      user = build(:user, first_name: "", last_name: "")
      expect(user.save).to be false
    end
  end
end
