class CreateQuestionTagsTable < ActiveRecord::Migration
  def up
    create_join_table :questions, :tags
  end
  def down
    drop_join_table :questions, :tags
  end

end
