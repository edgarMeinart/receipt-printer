# frozen_string_literal: true

describe ReceiptPrinter::Invoice::Item do
  let(:invoice_item) { described_class.new(name:, amount:, taxes:) }
  let(:name) { 'FooBar' }
  let(:amount) { 4242 }
  let(:taxes) { [double(ReceiptPrinter::Tax::BaseTax), ReceiptPrinter::Tax::ImportTax] }

  describe '.new' do
    subject { invoice_item }

    it { is_expected.to be_a(ReceiptPrinter::Invoice::Item) }
    it { is_expected.to have_attributes(name: be_a(String), base_amount: be_a(Integer)) }
    it { is_expected.to have_attributes(name:, base_amount: amount) }
  end

  describe '#total_amount' do
    subject { invoice_item.total_amount }

    context 'when taxfree' do
      let(:taxes) { [] }

      it { is_expected.to eq(amount) }
    end

    context 'when taxable' do
      let(:taxes) { [ReceiptPrinter::Tax::BaseTax, ReceiptPrinter::Tax::ImportTax] }

      it { is_expected.to eq(4882) }
    end
  end

  describe '#tax_amount' do
    subject { invoice_item.tax_amount }

    context 'when taxfree' do
      let(:taxes) { [] }

      it { is_expected.to eq(0) }
    end

    context 'when taxable' do
      let(:taxes) { [ReceiptPrinter::Tax::BaseTax, ReceiptPrinter::Tax::ImportTax] }

      it { is_expected.to eq(640) }
    end
  end
end
