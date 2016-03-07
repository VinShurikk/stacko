class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text
      t.integer :question_id
      t.integer :comment_id
      t.integer :rating, :default => 0
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
