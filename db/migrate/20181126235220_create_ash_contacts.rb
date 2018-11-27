class CreateAshContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :ash_contacts do |t|
      t.string :email
      t.string :trial

      t.timestamps
    end
  end
end
