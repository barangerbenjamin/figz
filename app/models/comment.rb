class Comment < ApplicationRecord
  belongs_to :route
  belongs_to :user

  validates :content, presence: true
end
