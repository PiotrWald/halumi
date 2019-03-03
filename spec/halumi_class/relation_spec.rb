require 'support/spec_helper'

RSpec.describe 'relation spec' do
  context 'when relation is defined' do
    before do
      class Subquery < Halumi::Query; end

      class Model
        def self.all
          :all
        end
      end

      class Test < Halumi::Query
        model Model
      end
    end

    it 'it has a relation' do
      expect(Test.instance_variable_get(:@relation)).to eq(:all)
    end

    context 'with inheritance' do
      before { class Test2 < Test; end }

      it 'it has a relation' do
        expect(Test2.instance_variable_get(:@relation)).to eq(:all)
      end
    end
  end
end
