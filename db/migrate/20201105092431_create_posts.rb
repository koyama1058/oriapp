class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title,          null: false
      t.integer :category_id,   null: false
      t.text :description,      null: false
      t.string :day_time
      t.integer :prefectures_id
      t.text :place
      t.text :budget
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
