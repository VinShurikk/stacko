class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text
      t.integer :answer_on
      t.integer :rating, :default => 0
      t.integer :view_count, :default => 0

      t.timestamps null: false
    end
  end
end
