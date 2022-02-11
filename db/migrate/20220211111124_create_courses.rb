class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses, id: :serial do |t|
      t.integer :author_id, null: false
      t.string :name, null: false
      t.string :description
      t.string :category
      t.text :public_id
      t.timestamps
    end
  end
end
