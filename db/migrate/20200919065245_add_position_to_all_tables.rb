class AddPositionToAllTables < ActiveRecord::Migration[6.0]
  def change
    add_column :notes, :position, :integer
    add_column :tasks, :position, :integer
    add_column :note_areas, :position, :integer
    add_column :task_areas, :position, :integer
    add_column :note_projects, :position, :integer
    add_column :task_projects, :position, :integer
  end
end
