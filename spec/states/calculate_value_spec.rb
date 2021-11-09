# frozen_string_literal: true

require_relative './../../src/states/calculate_value'
require_relative './../../src/states/read_first_scale'
require_relative './../../src/io_adapter'

describe States::CalculateValue do
  let(:adapter) { double 'IOAdapter' }

  before do
    allow(IOAdapter).to receive(:instance).and_return(adapter)
    allow(adapter).to receive(:write)
  end

  describe '#execute' do
    subject { described_class.new(first_scale: 'K', second_scale: 'F', value: '10').execute }

    context 'Result of convertation from 10 K to F' do
      it 'execution' do
        subject
        expect(adapter).to have_received(:write).with('Result: 10 °K = -441.67 °F')
      end
    end
  end

  describe '#next' do
    subject { described_class.new(first_scale: 'K', second_scale: 'F', value: '10').next }
    context 'Next state must be ReadFisrtScale' do
      it { is_expected.to be_a(States::ReadFirstScale) }
    end
  end
end
