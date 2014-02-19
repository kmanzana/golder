require 'csv'
require 'yaml'

class RuleBookBuilder
  include LookupKeyGenerator

  def initialize(input_filenames: nil, output_filename: nil)
    @input_filenames = input_filenames
    @output_filename = output_filename
    @descrepancies   = {}
  end

  def build
    File.open(output_filename, 'w+') do |file|
      file << rule_book_hash.to_yaml
    end
  end

  private

  attr_reader :input_filenames, :output_filename

  def rule_book_hash
    each_row_with_object({}) do |row, rule_book|
      next unless data?(row)

      new_data = extract_relevant_data(row)

      if @descrepancies[lookup_key(row)]
        unless @descrepancies[lookup_key(row)].include?(new_data)
          @descrepancies[lookup_key(row)] << new_data
        end
      else
        @descrepancies[lookup_key(row)] = [new_data]
      end
    end

    @descrepancies.each do |key, value|
      @descrepancies.delete(key) if value.length == 1
    end
  end

  def each_row_with_object(object)
    input_filenames.each do |filename|
      CSV.foreach(filename) { |row| yield row, object }
    end

    object
  end

  def data?(row)
    row.first =~ %r{\d+\/\d+\/\d+}
  end

  def extract_relevant_data(row)
    row.values_at(*LOOKUP_COLUMNS)
    .map(&:to_s)
    .map(&:strip)
  end
end
