class AddLegislatorToWords < ActiveRecord::Migration
  def change
    add_reference :words, :legislator, index: true, foreign_key: true
  end
end
