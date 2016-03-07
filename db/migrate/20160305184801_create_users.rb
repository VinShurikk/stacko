class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :password
      t.date :last_login
      t.integer :rating, :default => 0
      t.string :first_name
      t.string :last_name

      t.timestamps null: false
    end
  end
end
