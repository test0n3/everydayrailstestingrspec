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
class Task < ApplicationRecord
  belongs_to :project

  validates :project, presence: true
  validates :name, presence: true
end
