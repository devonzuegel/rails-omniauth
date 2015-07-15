class AddVisitorToEntry < ActiveRecord::Migration
  def change
    add_reference :entries, :visitor, index: true, foreign_key: true
  end
end
