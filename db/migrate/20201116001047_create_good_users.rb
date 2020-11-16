class CreateGoodUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :good_users do |t|
      t.integer :good_user_id
      t.integer :judge_user_id
      t.timestamps
    end
  end
end
