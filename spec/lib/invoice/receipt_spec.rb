# frozen_string_literal: true

describe ReceiptPrinter::Invoice::Receipt do
  describe '.generate' do
    subject { described_class.generate(invoice) }

    context 'when nil arg' do
      let(:invoice) { nil }

      it { expect_call.to raise_error(ArgumentError, /Invoice cannot be nil/) }
    end

    context 'when invoice without items' do
      let(:invoice) { ReceiptPrinter::Invoice.new }

      it { is_expected.to be_empty }
    end

    context 'when invoice with items' do
      let(:invoice) { ReceiptPrinter::Invoice.new }
      let(:base_tax) { ReceiptPrinter::Tax::BaseTax }
      let(:import_tax) { ReceiptPrinter::Tax::ImportTax }

      let(:item1) { ReceiptPrinter::Invoice::Item.new(name: 'Bike', amount: 1_00, taxes: [base_tax]) }
      let(:item2) do
        ReceiptPrinter::Invoice::Item.new(
          name: 'Imported CD disc',
          amount: 1_00,
          taxes: [base_tax, import_tax]
        )
      end

      before do
        invoice.add_item(item1)
        invoice.add_item(item2)
        invoice.add_item(item2)
      end

      it 'draws items with calculated amounts with totals' do
        is_expected.to include(
          include(1, "#{item1.name}:", '1.10'),
          include(2, "#{item2.name}:", '2.30'),
          include(nil, 'Sales Taxes:', '0.40'),
          include(nil, 'Total:', '3.40')
        )
      end
    end
  end
end
