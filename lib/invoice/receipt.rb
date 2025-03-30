# frozen_string_literal: true

module ReceiptPrinter
  class Invoice
    module Receipt
      module_function

      def generate(invoice)
        raise ArgumentError, 'Invoice cannot be nil' if invoice.nil?

        return [] if invoice.items.empty?

        [
          *draw_items(invoice),
          *draw_totals(invoice)
        ]
      end

      private_class_method def draw_items(invoice)
        grouped_items = invoice.items.group_by(&:name)

        grouped_items.map do |name, items|
          [items.count, "#{name}:", cents_to_decimal_str(items.sum(&:total_amount))]
        end
      end

      private_class_method def draw_totals(invoice)
        [
          [nil, 'Sales Taxes:', cents_to_decimal_str(invoice.total_tax_amount)],
          [nil, 'Total:', cents_to_decimal_str(invoice.total_amount)]
        ]
      end

      private_class_method def cents_to_decimal_str(value)
        format('%.2f', value / 100.0)
      end
    end
  end
end
