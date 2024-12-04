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
class Note < ApplicationRecord
  belongs_to :project
  belongs_to :user

  delegate :name, to: :user, prefix: true

  validates :message, presence: true

  scope :search, ->(term) {
    where("LOWER(message) LIKE ?", "%#{term.downcase}%")
  }

  has_one_attached :attachment

  validates :attachment, content_type: [
                           "image/jpeg",
                           "image/gif",
                           "image/png",
                           "application/pdf"
                         ]
end
