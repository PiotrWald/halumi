require 'support/spec_helper'

RSpec.describe 'param macro' do
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

      class Test3 < Halumi::Query
        model Model

        merge Subquery

        param :abc, Dry::Types['strict.integer']
        param :cde, Dry::Types['strict.integer']
      end
    end

    context 'when class is initalized and called' do
      subject { Test3.new(nil,  abc: 1, cde: 2) }

      it 'initlialize is called on the subquery' do
        expect(subject.instance_variable_get(:@sanatized_params)).to be_a Dry::Struct
      end
    end
  end
end
