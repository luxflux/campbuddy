class CreateCamps < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :domain, null: false

      t.timestamps null: false
    end

    create_table :camps do |t|
      t.string :name, null: false
      t.string :subdomain, null: false
      t.string :schema_name, index: true, null: false
      t.references :organization

      t.timestamps null: false
    end
  end
end
