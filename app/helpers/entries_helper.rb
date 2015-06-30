# app/helpers/entries_helper.rb
module EntriesHelper
  def word_count(entry)
    entry.body? ? entry.body.split.size : 0
  end

  def formatted_body(entry)
    entry.body? ? entry.body.gsub("\n", "\n\n") : nil
  end

  def formatted_date(entry)
    entry.created_at.strftime('%B %d, %Y')
  end
end
