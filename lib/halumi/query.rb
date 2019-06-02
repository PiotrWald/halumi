module Halumi
  class Query
    @subqueries = []
    @defined_params = []
    @relation = nil

    attr_reader :relation

    def self.inherited(klass)
      klass.instance_variable_set(:@subqueries, @subqueries.clone)
      klass.instance_variable_set(:@relation, @relation)
      klass.instance_variable_set(:@defined_params, [])
    end

    def self.model(model)
      @relation = model.all
    end

    def self.merge(subquery)
      @subqueries << subquery
    end

    def self.param(param_name, type = nil, &block)
      block ||= proc { type ? type[@params[param_name]] : @params[param_name] }

      define_method(param_name, block)

      @defined_params << param_name
    end

    def initialize(params = {}, relation = nil)
      @relation = relation&.all || class_relation
      @params = params
      @subqueries = subqueries
    end

    def call
      respond_to?(:execute) ? safe_execute : merge_subqueries
    end

    private

    def safe_execute
      validate_params && execute
    rescue Dry::Types::ConstraintError
      relation
    end

    def validate_params
      class_defined_params.each { |p| public_send(p) }
    end

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

    def class_defined_params
      self.class.instance_variable_get(:@defined_params)
    end
  end
end
