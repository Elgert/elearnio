class CreateEnrollments < ActiveRecord::Migration[6.0]
  def change
    create_table :enrollments do |t|
      t.references :courses, foreign_key: true, null: false
      t.references :users, foreign_key: true, null: false
    end
  end
end
