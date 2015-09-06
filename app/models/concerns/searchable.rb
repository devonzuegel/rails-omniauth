# app/models/concerns/searchable.rb
module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks # Automatically update es index on change.

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

    def es_search(query = nil)
      return all if query.blank?

      options = {}
      result = search(query, options)
      result.records.to_a  # Return results as ActiveRecord db records.
    end

    def es_search_by_ids(query, ids)
      es_search(query).select { |e| ids.include?(e.id) }
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
