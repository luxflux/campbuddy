class AddBirthdayAndCellphoneToUser < ActiveRecord::Migration
  def change
    add_column :users, :birthday, :date
    add_column :users, :cellphone, :string
  end
end
