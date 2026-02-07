class AddDescriptionToGoals < ActiveRecord::Migration[8.1]
  def change
    add_column :goals, :description, :text
  end
end
