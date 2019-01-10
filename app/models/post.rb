class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :user_id, :titulo, :cuerpo, presence: true
  validates :cuerpo, length: { minimum: 250 }
end
