class RemoveOneTimeTokenFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :one_time_token
  end
end
