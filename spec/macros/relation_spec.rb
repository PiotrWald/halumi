require 'support/spec_helper'

RSpec.describe 'query with relation macro' do
  before do
    class Model < ActiveRecord::Base; end
  end

  subject { tested_class.new }

  context 'used inside a class definition' do
    before do
      class TestClass < Halumi::Query
        model Model

        def execute
          relation
        end
      end
    end

    let(:tested_class) { TestClass }

    it 'returns an active record relation' do
      expect(subject.call).to be_a(ActiveRecord::Relation)
    end
  end

  context 'used inside a superclass' do
    before do
      class TestClass < Halumi::Query
        model Model

        def execute
          relation
        end
      end

      class SecondTestClass < TestClass; end
    end

    let(:tested_class) { SecondTestClass }

    it 'returns an active record relation' do
      expect(subject.call).to be_a(ActiveRecord::Relation)
    end
  end
end
