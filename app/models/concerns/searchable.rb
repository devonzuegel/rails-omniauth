# app/models/concerns/searchable.rb
module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks # Automatically update es index on change.
    DEFAULT_FUZZINESS = 5

    index_name [Rails.env, model_name.collection.gsub(%r{/}, '-')].join('_')
  end

  # Class methods
  module ClassMethods
    def recreate_es_index!
      __elasticsearch__.create_index! index: index_name, force: true
      sleep 1 # Wait for index recreation to complete.
      import  # import ActiveRecords into ElasticSearch.
      sleep 1 # Wait for import to complete.
    end

    def es_search(query = nil, _fuzzy = true)
      return all if query.blank?
      # query = fuzzy_query(query) if fuzzy

      # Entry.search(query:{match:{_all:{query:'f', fuzziness:2}}}).records
      result = search query: { match: { _all: { query: query, fuzziness: 2 } } } # (query)
      result.records.to_a  # Return results as ActiveRecord db records.
    end

    def es_search_by_ids(query, ids)
      es_search(query).select { |e| ids.include?(e.id) }
    end

    def fuzzy_query(query, fuzz = DEFAULT_FUZZINESS)
      {
        query: {
          match: {
            _all: {
              query: query,
              fuzz:  fuzz
            }
          }
        }
      }
    end
  end

  # Instance methods
  module InstanceMethods
  end

  def self.included(receiver)
    receiver.extend ClassMethods
    receiver.send :include, InstanceMethods
  end
end
