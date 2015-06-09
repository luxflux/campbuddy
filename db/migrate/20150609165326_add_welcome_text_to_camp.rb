class AddWelcomeTextToCamp < ActiveRecord::Migration
  def up
    add_column :camps, :welcome_text, :string
    Camp.update_all welcome_text: 'Mit dem Absenden des Formulars meldest Du dich verbindlich an.'
  end

  def down
    remove_column :camps, :welcome_text
  end
end
