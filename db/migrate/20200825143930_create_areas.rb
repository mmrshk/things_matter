class CreateAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :areas, id: :uuid, default: -> { 'uuid_generate_v4()' } do |t|
      t.string :name, default: ''
      t.string :type, null: false
      t.belongs_to :user_account, type: :uuid, foreign_key: true, index: true

      t.timestamps
    end
  end
end
