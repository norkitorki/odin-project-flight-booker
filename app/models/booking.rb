class Booking < ApplicationRecord
  belongs_to :flight

  has_and_belongs_to_many :passengers

  validates :passengers, 
    presence: true

  accepts_nested_attributes_for :passengers, 
    allow_destroy: true,
    reject_if: :all_blank
end
