class CreatePhilosophers < ActiveRecord::Migration[7.0]
  def change
    create_table :philosophers do |t|
      t.string :firstName, null:false
      t.string :lastName, null:false
      t.integer :birthYear, null:false
      t.integer :deathYear, null:true
      t.text :biography, null:true

      t.timestamps
    end
  end
end
