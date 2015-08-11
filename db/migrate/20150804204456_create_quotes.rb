class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.text :body
      t.string :speaker
      t.references :word, index: true, foreign_key: true
      t.float :sentiment
      t.string :bio_id

      t.timestamps null: false
    end
  end
end
