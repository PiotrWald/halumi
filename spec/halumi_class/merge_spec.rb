require 'support/spec_helper'

RSpec.describe 'merge macro' do
  context 'used inside a class definiion' do
    before do
      class Subquery < Halumi::Query
        def call
          {}
        end
      end

      class Model
        def self.all
          :all
        end
      end

      class Test < Halumi::Query
        merge Subquery
      end
    end

    it 'has a Subquery as one of the subqueries' do
      expect(Test.instance_variable_get(:@subqueries).first).to eq(Subquery)
    end

    context 'with inheritance' do
      before { class Test1 < Test; end }

      it 'has a Subquery as one of the subqueries' do
        expect(Test1.instance_variable_get(:@subqueries).first).to eq(Subquery)
      end
    end

    context 'when initializing a query' do
      subject { Test.new }

      it 'has a instance of Subquery as one of the subqueries' do
        expect(subject.instance_variable_get(:@subqueries).first.class).to eq(Subquery)
      end

      context 'when called' do
        it 'returns a hash' do
          expect(subject.call).to be_a Hash
        end
      end
    end
  end
end
