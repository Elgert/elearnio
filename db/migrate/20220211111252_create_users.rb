class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :serial do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.text :public_id
      t.timestamps
    end
  end
end
