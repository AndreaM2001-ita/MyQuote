class CreateQuotes < ActiveRecord::Migration[7.0]
  def change
    create_table :quotes do |t|
      t.string :quoteText, null:false
      t.boolean :isPublic, null:false, dafault:true
      t.date :datePosted, null:false
      t.references :User, null: false, foreign_key: true
      t.references :Philosopher, null: true, foreign_key: true

      t.timestamps
    end
  end
end
