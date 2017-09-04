require 'spec_helper'

RSpec.describe ExchangeRateConversionRequest do
  describe '.new' do
    it 'cleans the values with which it is initialized' do
      expect(Rack::Utils).to receive(:escape_html).with('2018-01-01')
      expect(Rack::Utils).to receive(:escape_html).with('USD')
      expect(Rack::Utils).to receive(:escape_html).with('GBP')
      expect(Rack::Utils).to receive(:escape_html).with('10')

      described_class.new(params_hash)
    end
  end

  describe '#run' do
    context 'when the request is successful' do
      let(:date) { Date.parse('2018-01-01') }
      it 'returns a success status and the conversion rate' do
        expect(ExchangeRateJt).to receive(:at).with(date, 'USD', 'GBP')
                                              .and_return(status: :success, rate: 10)

        request = described_class.new(params_hash)
        request.run

        expect(request.outcome).to eq :success
        expect(request.result_message).to eq '10 USD = 100 GBP'
      end
    end

    context 'when the request is unsuccessful' do
      it 'returns a failure if the date is invalid' do
        request = described_class.new(params_hash(date: 'wibble'))
        request.run

        expect_failure(request, 'Error: invalid date')
      end

      it 'returns a failure if any params are missing' do
        request = described_class.new(params_hash(base: ''))
        request.run

        expect_failure(request, 'Error: Please fill in all fields')
      end

      it 'returns a failure if the amount is not a number greater than zero' do
        request = described_class.new(params_hash(amount: 'bibble'))
        request.run

        expect_failure(request, 'Error: Amount must be a number greater than zero')
      end
    end
  end

  private

  def params_hash(date: '2018-01-01', base: 'USD', counter: 'GBP', amount: '10')
    { date: date, base: base, counter: counter, amount: amount }
  end

  def expect_failure(request, message)
    expect(request.outcome).to eq :failure
    expect(request.result_message).to eq message
  end
end
