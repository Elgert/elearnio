class CreateEnrollments < ActiveRecord::Migration[6.0]
  def change
    create_table :enrollments do |t|
      t.references :course, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
    end

    add_foreign_key :courses, :users, column: :author_id
  end
end
