module Halumi
  class Query
    @subqueries = []
    @relation = nil

    attr_reader :relation

    def self.inherited(klass)
      klass.instance_variable_set(:@subqueries, @subqueries.clone)
      klass.instance_variable_set(:@relation, @relation)
    end

    def self.model(model)
      @relation = model.all
    end

    def self.merge(subquery)
      @subqueries << subquery
    end

    def self.param(param_name, &block)
      block ||= proc { @params[param_name] }

      define_method(param_name, block)
    end

    def initialize(params = {}, relation = nil)
      @relation = relation&.all || class_relation
      @params = params
      @subqueries = subqueries
    end

    def call
      respond_to?(:execute) ? execute : merge_subqueries
    end

    private

    def merge_subqueries
      @subqueries.map(&:call).reduce(&:merge)
    end

    def subqueries
      class_subqueries.map do |query|
        query.new(@params, @relation)
      end
    end

    def class_subqueries
      self.class.instance_variable_get(:@subqueries)
    end

    def class_relation
      self.class.instance_variable_get(:@relation)
    end
  end
end
