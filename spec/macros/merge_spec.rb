require 'support/spec_helper'

RSpec.describe 'quer with merge macro' do
  before do
    class Subquery < Halumi::Query
      def execute
        relation
      end
    end

    class Model < ActiveRecord::Base; end

    class TestClass < Halumi::Query
      model Model

      merge Subquery
    end
  end

  subject { tested_class.new }

  context 'used inside a class definiion' do
    let(:tested_class) { TestClass }

    it 'returns an active record relation' do
      expect(subject.call).to be_a(ActiveRecord::Relation)
    end

    context 'used inside a superclass' do
      let(:tested_class) { SecondTestClass }

      before do
        class SecondTestClass < TestClass; end
      end

      it 'returns an active record relation' do
        expect(subject.call).to be_a(ActiveRecord::Relation)
      end
    end
  end
end
