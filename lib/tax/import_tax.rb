# frozen_string_literal: true

module ReceiptPrinter
  module Tax
    class ImportTax < BaseTax
      IMPORT_TAX_RATE = 5 # 5%

      # @return [Integer]
      def tax_rate
        IMPORT_TAX_RATE
      end
    end
  end
end
