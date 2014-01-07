require 'csv'
require 'yaml'

class RuleBookBuilder
  include LookupKeyGenerator

  def initialize(input_filename: nil, output_filename: nil)
    @input_filename  = input_filename
    @output_filename = output_filename
  end

  def build
    File.open(output_filename, 'w+') do |file|
      file << rule_book_hash.to_yaml
    end
  end

  private

  def rule_book_hash
    each_row_with_object(input_filename, {}) do |row, rule_book|
      next unless is_data(row)
      rule_book[lookup_key(row)] ||= extract_relevant_data(row)
    end
  end

  def each_row_with_object(filename, object)
    CSV.foreach(filename) do |row|
      yield row, object
    end

    object
  end

  def is_data(row)
    row.first =~ %r{\d+\/\d+\/\d+}
  end

  def extract_relevant_data(row)
    row[G..Y]
    .map(&:to_s)
    .map(&:strip)
    .unshift(*([nil] * 6))
  end

  attr_reader :input_filename, :output_filename
end
