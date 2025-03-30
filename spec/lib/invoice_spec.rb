# frozen_string_literal: true

describe ReceiptPrinter::Invoice do
  let(:invoice) { described_class.new }

  describe '.new' do
    subject { described_class.new }

    it { is_expected.to have_attributes(items: []) }
    it { is_expected.to be_a(described_class) }
  end

  describe '#add_item' do
    subject { invoice.add_item(item) }

    let(:invoice) { described_class.new }
    let(:item) { nil }

    context 'when no item is provided' do
      it { expect_call.to raise_error(ArgumentError, /Item cannot be nil/) }
    end

    context 'when item is provided' do
      let(:item) { double('Item') }

      it { expect_call.to change { invoice.items.count }.by(1) }
    end
  end

  describe '#total_amount' do
    subject { invoice.total_amount }

    let(:item1) { ReceiptPrinter::Invoice::Item.new(name: 'Foo', amount: 10) }
    let(:item2) { ReceiptPrinter::Invoice::Item.new(name: 'Bar', amount: 20) }
    let(:item3) { ReceiptPrinter::Invoice::Item.new(name: 'Baz', amount: 30) }

    context 'when no items are added' do
      it { is_expected.to eq(0.0) }
    end

    context 'when items are added' do
      before do
        invoice.add_item(item1)
        invoice.add_item(item2)
        invoice.add_item(item3)
      end

      it { is_expected.to eq(60.0) }
    end
  end

  describe '#total_tax_amount' do
    subject { invoice.total_tax_amount }

    let(:item1) { ReceiptPrinter::Invoice::Item.new(name: 'Foo', amount: 100, taxes: tax1) }
    let(:item2) { ReceiptPrinter::Invoice::Item.new(name: 'Bar', amount: 100, taxes: [tax1, tax2]) }
    let(:tax1) { ReceiptPrinter::Tax::BaseTax }
    let(:tax2) { ReceiptPrinter::Tax::ImportTax }

    context 'when no items are added' do
      it { is_expected.to eq(0.0) }
    end

    context 'when items are added' do
      before do
        invoice.add_item(item1)
        invoice.add_item(item2)
      end

      it { is_expected.to eq(25.0) }
    end
  end
end
