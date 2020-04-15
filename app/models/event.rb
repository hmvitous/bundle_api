class Event < ApplicationRecord
  validates_presence_of :title, :description, :category
  enum category: [ :outdoors, :sports, :food, :games, :casual ]
end
