class CreateBadUsres < ActiveRecord::Migration[6.0]
  def change
    create_table :bad_usres do |t|
      t.references :user,   null: false, foreign_key: true
      t.timestamps
    end
  end
end
