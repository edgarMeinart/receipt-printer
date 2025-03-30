# frozen_string_literal: true

module ReceiptPrinter
  module TaxDetective
    module_function

    # @returns [Array<BaseTax|ImportTax>]
    def call(item_name)
      item_name = item_name.strip.downcase

      applied_taxes = []

      applied_taxes << Tax::BaseTax unless food?(item_name) || book?(item_name) || meds?(item_name)

      applied_taxes << Tax::ImportTax if imported?(item_name)

      applied_taxes
    end

    # @returns [Bool]
    private_class_method def food?(item_name)
      item_name.include?('chocolate')
    end

    # @returns [Bool]
    private_class_method def book?(item_name)
      item_name.include?('book')
    end

    # @returns [Bool]
    private_class_method def meds?(item_name)
      item_name.include?('pill')
    end

    private_class_method def imported?(item_name)
      item_name.include?('imported')
    end
  end
end
