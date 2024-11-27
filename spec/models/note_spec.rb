require 'rails_helper'

RSpec.describe Note, type: :model do
  it "is valid with a message and user" do
    user = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "joetester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    project = user.projects.create(
      name: "Test Project",
    )
    note = project.notes.build(
      message: "This is the first message",
      user: user
    )
    expect(note).to be_valid
    expect(note.errors.size).to eq 0
  end

  it "is invalid if note doesn't have message" do
    user = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "joetester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze"
    )
    project = user.projects.create(
      name: "Test Project"
    )
    note = project.notes.build(
      message: nil,
      user: user
    )
    note.valid?
    expect(note.errors[:message]).to include("can't be blank")
  end

  it "is invalid with an empty user" do
      user = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "joetester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    project = user.projects.create(
      name: "Test Project",
    )
    note = project.notes.build(
      message: "This is the first message",
      user: nil
    )
    note.valid?
    expect(note).to_not be_valid
  end

  it "returns notes that match the search term" do
    user = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "joetester@example.com",
      password: "dottle-nouveau-paviliion-tights-furze",
    )
    project = user.projects.create(
      name: "Test Project",
    )
    note1 = project.notes.create(
      message: "This is the first note.",
      user: user,
    )
    note2 = project.notes.create(
      message: "This is the second note.",
      user: user,
    )
    note3 = project.notes.create(
      message: "First, preheat the oven.",
      user: user,
    )
    expect(Note.search("first")).to include(note1, note3)
    expect(Note.search("first")).to_not include(note2)
    expect(Note.search("note")).to include(note1, note2)
    expect(Note.search("note")).to_not include(note3)
  end

  it "returns an empty collection when no results are found" do
    user = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "joetester@example.com",
      password: "dottle-nouveau-paviliion-tights-furze",
    )
    project = user.projects.create(
      name: "Test Project",
    )
    note1 = project.notes.create(
      message: "This is the first note.",
      user: user,
    )
    note2 = project.notes.create(
      message: "This is the second note.",
      user: user,
    )
    note3 = project.notes.create(
      message: "First, preheat the oven.",
      user: user,
    )
    expect(Note.search("message")).to be_empty
  end
end
