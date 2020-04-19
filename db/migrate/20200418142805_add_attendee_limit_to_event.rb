class AddAttendeeLimitToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :attendee_limit, :integer
  end
end
