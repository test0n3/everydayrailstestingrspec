# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  authentication_token   :string
#  location               :string
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe "attributes" do
    it "is valid with a first name, last name, email, and password" do
      user = User.new(
        first_name: "Aaron",
        last_name: "Sumner",
        email: "tester@example.com",
        password: "dottle-nouveau-pavillion-tights-furze",
      )
      expect(user).to be_valid
    end

    it "is invalid without a first name" do
      user = User.new(first_name: nil)
      user.valid?
      # expect(user.errors.size).to eq 1
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it "is invalid without a last name" do
      user = User.new(last_name: nil)
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    it "is invalid without an email address" do
      user = User.new(email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid with a duplicate email address" do
      User.create(
        first_name: "Joe",
        last_name: "Tester",
        email: "tester@example.com",
        password: "dottle-nouveau-pavilion-tights-furze",
      )
      user = User.new(
        first_name: "Jane",
        last_name: "Tester",
        email: "tester@example.com",
        password: "dottle-nouveau-pavilion-tights-furze",
      )
      user.valid?
      expect(user.errors[:email]).to include("has already been taken")
    end
  end

  describe "methods" do
    it "returns a user's full name as a string" do
      user = User.new(
        first_name: "Aaron",
        last_name: "Sumner",
        email: "tester@example.com",
        password: "dottle-nouveau-pavilion-tights-furze",
      )
      expect(user.name).to eq "Aaron Sumner"
    end
  end
end
