class ChangeQuestions < ActiveRecord::Migration
  def up
    add_column :questions, :title, :string, null: false, default: ''
    remove_column :questions, :answer_on
  end
end
