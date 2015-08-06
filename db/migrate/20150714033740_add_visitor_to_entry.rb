# db/migrate/20150714033740_add_visitor_to_entry.rb
class AddVisitorToEntry < ActiveRecord::Migration
  def change
    add_reference :entries, :visitor, index: true, foreign_key: true
  end
end
