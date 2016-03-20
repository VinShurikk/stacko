class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :question_id
      t.string :text
      t.integer :user_id
      t.integer :rating, :default => 0

      t.timestamps
    end
  end
end
