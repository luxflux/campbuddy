class CreatePicOfTheDays < ActiveRecord::Migration
  def change
    create_table :pic_of_the_days do |t|
      t.string :image

      t.timestamps null: false
    end
  end
end
