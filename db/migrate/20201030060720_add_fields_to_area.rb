class AddFieldsToArea < ActiveRecord::Migration[6.0]
  def change
    add_column :note_areas, :deleted_date, :date
    add_column :task_areas, :deleted_date, :date
    add_column :note_areas, :deleted, :boolean, default: false
    add_column :task_areas, :deleted, :boolean, default: false
  end
end
