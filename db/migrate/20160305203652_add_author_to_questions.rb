class AddAuthorToQuestions < ActiveRecord::Migration
  def up
    add_column :questions, :user_id, :integer
  end

  def down
    remove_column :questions, :user_id
  end
end
