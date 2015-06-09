class AddAllowSignUpToCamp < ActiveRecord::Migration
  def change
    add_column :camps, :allow_sign_up, :boolean, default: false
  end
end
