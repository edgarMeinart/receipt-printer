# frozen_string_literal: true

describe ReceiptPrinter::Tax::BaseTax do
  describe '.calculate' do
    subject { described_class.calculate(amount) }

    let(:amount) { 1_00 }

    it 'calculates and returns the tax amount' do
      expect(subject).to eq(10)
    end

    context 'when tax calc requires rounding' do
      it 'rounds tax up to the nearest 0.05 for given rate and shelf price' do
        expect(described_class.calculate(14_99)).to eq(1_50)
      end
    end
  end
end
