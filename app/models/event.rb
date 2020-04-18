class Event < ApplicationRecord
  validates_presence_of :title, :description, :category, :attendee_limit
  enum category: [ :outdoors, :sports, :food, :games, :casual ]
  belongs_to :user
  has_many :attendees
end
