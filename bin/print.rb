#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/invoice'

invoice_file = ARGV[0]
INPUT_VALIDATION_REGEXP = /(^\s*[1-9]\d*\s+.+\s+at\s+\d+(\.\d{2})?\s*$)|(^end$)|(^exit$)/

if invoice_file.nil? || !File.exist?(invoice_file) || File.zero?(invoice_file)
  puts 'Use: ./print.rb <input-file>'

  exit 1
end

lines = File.readlines(invoice_file, chomp: true)

def valid_line?(line)
  INPUT_VALIDATION_REGEXP.match?(line)
end

def parse_item(input)
  splitted = input.split(' ')

  quantity = splitted.shift
  amount = splitted.pop
  name = splitted[(0..-2)].join(' ')

  {
    quantity: quantity.to_i,
    name:,
    amount: amount.to_f * 100,
    is_imported: name.downcase.start_with?('imported')
  }
end

invoice = ReceiptPrinter::Invoice.new

lines.each_with_index do |line, index|
  unless valid_line?(line)
    puts "Invalid input at line #{index + 1}: #{line}, must match `<count> <item name> at <price>`}"
    exit 1
  end

  parsed_item = parse_item(line)
  taxes_to_apply = ReceiptPrinter::TaxDetective.call(parsed_item.fetch(:name))
  invoice_item = ReceiptPrinter::Invoice::Item.new(**parsed_item.slice(:name, :amount), taxes: taxes_to_apply)
  parsed_item.fetch(:quantity).times { invoice.add_item(invoice_item) }
end

ReceiptPrinter::Invoice::Receipt.generate(invoice).each do |item|
  puts item.join(' ')
end
