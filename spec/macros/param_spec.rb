require 'support/spec_helper'

RSpec.describe 'param' do
  context 'used inside a class definition' do
    before do
      class Model < ActiveRecord::Base; end

      class TestClass < Halumi::Query
        model Model

        param :first_param
        param :second_param
      end
    end

    context 'with a hash' do
      let(:hash) do
        Hash[
          first_param: :first_value,
          second_param: :second_value
        ]
      end

      subject { TestClass.new(hash) }

      it 'defines methods from hash keys' do
        expect(subject).to respond_to(:first_param)
        expect(subject).to respond_to(:second_param)
      end

      it 'returns hash values' do
        expect(subject.first_param).to eq(:first_value)
        expect(subject.second_param).to eq(:second_value)
      end
    end
  end
end
