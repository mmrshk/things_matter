class CreateSchemaExtensions < ActiveRecord::Migration[6.0]
  def change
    create_table :schema_extensions do |t|
      enable_extension "pgcrypto"
      enable_extension "plpgsql"
      enable_extension "uuid-ossp"
    end
  end
end
