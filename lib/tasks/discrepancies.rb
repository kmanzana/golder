require 'csv'
require 'yaml'

class Discrepancies
  include LookupKeyGenerator

  def initialize(input_filenames: nil, output_filename: nil)
    @input_filenames = input_filenames
    @output_filename = output_filename
    @discrepancies   = {}
    @formatted_discrepancies = []
  end

  def build
    CSV.open(output_filename, 'wb') do |csv|
      csv << ('C'..'F').to_a + LOOKUP_COLUMNS_ARRAY
      discrepancies_array.each { |line| csv << line }
    end
  end

  private

  attr_reader :input_filenames, :output_filename

  def discrepancies_array
    each_row_with_object({}) do |row, discrepancies|
      next unless data?(row)

      new_data = extract_relevant_data(row)

      if @discrepancies[lookup_key(row)]
        unless @discrepancies[lookup_key(row)].include?(new_data)
          @discrepancies[lookup_key(row)] << new_data
        end
      else
        @discrepancies[lookup_key(row)] = [new_data]
      end
    end

    @discrepancies.delete_if { |key, value| value.length == 1 }

    @discrepancies.each do |lookup, data_values|
      lookup_cols = lookup.split ';'
      first_rule = lookup_cols + data_values.shift

      rules = data_values.map { |rule|  [nil, nil, nil, nil].push *rule }
      rules.unshift first_rule

      @formatted_discrepancies += rules
    end

    @formatted_discrepancies
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
