class EventListSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :category, :attendees
end
