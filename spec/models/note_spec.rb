# == Schema Information
#
# Table name: notes
#
#  id         :integer          not null, primary key
#  message    :text
#  project_id :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Note, type: :model do
  before(:example) do
    @user = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "joetester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze"
    )

    @project = @user.projects.create(
      name: "Test Project"
    )
  end

  it "is valid with a user, project, and message" do
    note = Note.new(
      message: "This is a sample note",
      user: @user,
      project: @project
    )
    expect(note).to be_valid
  end

  it "is invalid without a message" do
    note = Note.new(message: nil)
    note.valid?
    expect(note.errors[:message]).to include("can't be blank")
  end

  describe "search message for a term" do
    before(:example) do
      @note1 = @project.notes.create(
        message: "This is the first note.",
        user: @user,
      )
      @note2 = @project.notes.create(
        message: "This is the second note.",
        user: @user,
      )
      @note3 = @project.notes.create(
        message: "First, preheat the oven",
        user: @user,
      )
    end

    context "when a match is found" do
      it "returns notes that match the search term" do
        expect(Note.search("first")).to include(@note1, @note3)
        expect(Note.search("first")).to_not include(@note2)
        expect(Note.search("note")).to include(@note1, @note2)
        expect(Note.search("note")).to_not include(@note3)
      end
    end

    context "when no match is found" do
      it "returns an empty collection when no results are found" do
        expect(Note.search("message")).to be_empty
      end
    end
  end

  after(:example) do
    @note1.destroy if @note1.present?
    @note2.destroy if @note2.present?
    @note3.destroy if @note3.present?
    @project.destroy
    @user.destroy
  end
end
