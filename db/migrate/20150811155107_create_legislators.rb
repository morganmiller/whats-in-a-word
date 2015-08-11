class CreateLegislators < ActiveRecord::Migration
  def change
    create_table :legislators do |t|
      t.string :first_name
      t.string :last_name
      t.string :party
      t.string :phone
      t.references :state, index: true, foreign_key: true
      t.string :term_start
      t.string :term_end
      t.string :twitter_handle
      t.string :title
      t.string :website
      t.string :bio_id

      t.timestamps null: false
    end
  end
end
