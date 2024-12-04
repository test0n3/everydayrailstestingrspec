# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  name       :string
#  project_id :integer          not null
#  completed  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Task, type: :model do
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

  it "is valid with a name" do
    @task = @project.tasks.create(
      name: "Test Task"
      )
    expect(@task).to be_valid
  end

  it "is invalid without a name" do
    @task = @project.tasks.new(name: nil)
    @task.valid?
    expect(@task.errors[:name]).to include("can't be blank")
  end

  after(:example) do
    @task.destroy
    @project.destroy
    @user.destroy
  end
end
