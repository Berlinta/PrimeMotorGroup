class Car < ApplicationRecord

  belongs_to :line
  has_many :reviews
  has_many :users, through: :reviews

  validates :name, :description, :drive, :make, presence: true


  scope :car_make, -> { order('make') }
  scope :reviewed, -> { order(:reviews).distinct("reviews.car_id") } #order cars by ther ID using reviewd method from cars controller

end