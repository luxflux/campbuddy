class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :message

      t.timestamps
    end
  end
end
