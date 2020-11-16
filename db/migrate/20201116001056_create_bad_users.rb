class CreateBadUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :bad_users do |t|
      t.integer :bad_user_id
      t.integer :judge_user_id
      t.timestamps
    end
  end
end
