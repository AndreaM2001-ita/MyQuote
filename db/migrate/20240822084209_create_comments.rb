class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :comment, null:false
      t.date :datePosted, null:false
      t.references :User, null: false, foreign_key: true
      t.references :Quote, null: false, foreign_key: true

      t.timestamps
    end
  end
end
