class AddLegislatorToQuotes < ActiveRecord::Migration
  def change
    add_reference :quotes, :legislator, index: true, foreign_key: true
  end
end
