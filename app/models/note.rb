class Note < ApplicationRecord
  belongs_to :user

  validates :city, presence: true
  validates :note_text, presence: true, length: { maximum: 1000 }
  validates :temperature, numericality: true, allow_blank: true

end