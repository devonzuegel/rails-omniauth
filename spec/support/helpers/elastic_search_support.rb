# /zen-writer/spec/support/helpers/elastic_search_support.rb
module ElasticSearchSupport
  # Destroy and recreate indices for all Searchable models.
  def recreate_all_indices!
    [Entry].each(&:recreate_es_index!)
  end
end
