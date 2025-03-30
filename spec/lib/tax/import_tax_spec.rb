# frozen_string_literal: true

describe ReceiptPrinter::Tax::ImportTax do
  describe '.calculate' do
    subject { described_class.calculate(amount) }

    let(:amount) { 100 }

    it 'calculates and returns the tax amount' do
      expect(subject).to eq(5)
    end
  end
end
