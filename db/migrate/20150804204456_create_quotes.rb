class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.text :body
      t.string :speaker
      t.references :word, index: true, foreign_key: true
      t.integer :sentiment

      t.timestamps null: false
    end
  end
end
