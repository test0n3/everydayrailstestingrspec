# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  due_on      :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  completed   :boolean
#
class Project < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :user_id }

  belongs_to :owner, class_name: "User", foreign_key: :user_id
  has_many :notes
  has_many :tasks

  def late?
    due_on.in_time_zone < Date.current.in_time_zone
  end
end
