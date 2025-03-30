# frozen_string_literal: true

module ReceiptPrinter
  class Invoice
    class Item
      attr_reader :name, :base_amount

      def initialize(name:, amount:, taxes: [])
        @name = name
        @base_amount = amount
        @taxes = Array(taxes)
      end

      def total_amount
        @total_amount ||= base_amount + tax_amount
      end

      def tax_amount
        @tax_amount = @taxes.sum { |tax| tax.calculate(base_amount) }
      end
    end
  end
end
