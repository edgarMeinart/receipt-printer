# frozen_string_literal: true

module ReceiptPrinter
  module Tax
    class BaseTax
      BASE_TAX_RATE = 10 # 10%

      def self.calculate(base_amount)
        new(base_amount).tax_amount
      end

      def initialize(amount)
        @base_amount = amount
      end

      # @return [Float] the tax amount for the given amount
      def tax_amount
        raw_tax = @base_amount * tax_rate.to_f / 100.0

        (raw_tax / 5.0).ceil * 5
      end

      private

      def tax_rate
        BASE_TAX_RATE
      end
    end
  end
end
