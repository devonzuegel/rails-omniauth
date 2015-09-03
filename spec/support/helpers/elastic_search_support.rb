# /zen-writer/spec/support/helpers/elastic_search_support.rb
module ElasticSearchSupport
  def recreate_all_indices!
    [Entry].each do |model|
      model.recreate_es_index!
    end
  end
end
