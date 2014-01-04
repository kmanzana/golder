require 'csv'
require 'yaml'

class RuleBookBuilder
  include LookupKeyGenerator

  def initialize(input_filename, output_filename)
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
      rule_book[lookup_key(row)] ||= row[G..H].map(&:strip)
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

  attr_reader :input_filename, :output_filename
end
