# frozen_string_literal: true

describe ReceiptPrinter::TaxDetective do
  describe '#call' do
    subject(:call) { described_class.call(item_name) }

    context 'when food' do
      let(:item_name) { 'Chocolate' }

      it { is_expected.to be_empty }
    end

    context 'when book' do
      let(:item_name) { 'Book' }

      it { is_expected.to be_empty }
    end

    context 'when meds' do
      let(:item_name) { 'Aspirin pill' }

      it { is_expected.to be_empty }
    end

    context 'when other' do
      let(:item_name) { 'shovel' }

      it { is_expected.to eq([ReceiptPrinter::Tax::BaseTax]) }
    end

    context 'when imported' do
      context 'when food' do
        let(:item_name) { 'imported chocolate' }

        it { is_expected.to eq([ReceiptPrinter::Tax::ImportTax]) }
      end

      context 'when book' do
        let(:item_name) { 'imported book' }

        it { is_expected.to eq([ReceiptPrinter::Tax::ImportTax]) }
      end

      context 'when meds' do
        let(:item_name) { 'imported aspirin pill' }

        it { is_expected.to eq([ReceiptPrinter::Tax::ImportTax]) }
      end

      context 'when other' do
        let(:item_name) { 'imported shovel' }

        it { is_expected.to eq([ReceiptPrinter::Tax::BaseTax, ReceiptPrinter::Tax::ImportTax]) }
      end
    end
  end
end
