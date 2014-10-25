class AddImpressionToEvent < ActiveRecord::Migration
  def change
    add_column :events, :impression, :string
  end
end
