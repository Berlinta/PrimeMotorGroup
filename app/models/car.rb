class Car < ApplicationRecord

  belongs_to :line
  has_many :reviews
  has_many :users, through: :reviews

  validates :name, :description, :drive, :line, presence: true
  #validates presence: true, on: :create

  scope :car_line, -> { order('line') }
  scope :reviewed, -> { joins(:reviews).distinct("reviews.car_id") }

end