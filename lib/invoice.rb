# frozen_string_literal: true

require_relative 'invoice/item'
require_relative 'invoice/receipt'
require_relative 'tax/base_tax'
require_relative 'tax/import_tax'
require_relative 'tax_detective'

module ReceiptPrinter
  class Invoice
    attr_reader :items

    def initialize
      @items = []
    end

    # @returns [nil], only side effect
    def add_item(item)
      raise ArgumentError, 'Item cannot be nil' if item.nil?

      @items << item

      nil
    end

    # @returns [Integer]
    def total_amount
      @items.sum(&:total_amount)
    end

    # @returns [Integer]
    def total_tax_amount
      @items.sum(&:tax_amount)
    end
  end
end
