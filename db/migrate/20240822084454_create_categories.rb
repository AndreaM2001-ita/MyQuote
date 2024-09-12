class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :catName, null:false

      t.timestamps
    end
    add_index :categories, :catName, unique: true
  end
end
