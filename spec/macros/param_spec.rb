require 'support/spec_helper'

RSpec.describe 'param' do
  context 'without specyfing types' do
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

  context 'with a type specified' do
    before do
      require 'dry-types'

      class TestClass < Halumi::Query
        model Model

        param :paramter, Dry::Types['strict.integer']
      end
    end

    subject { TestClass.new(paramter: paramter) }

    context 'initialized with correct paramter' do
      let(:paramter) { 3 }

      it 'returns the parameter' do
        expect(subject.paramter).to eq(3)
      end
    end

    context 'with invalid paramter' do
      let(:paramter) { '3' }

      it 'raises an error' do
        expect { subject.paramter }.to raise_error(Dry::Types::ConstraintError)
      end
    end
  end
end
