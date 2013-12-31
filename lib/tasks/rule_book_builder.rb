require 'csv'
require 'yaml'

class RuleBookBuilder
  ('A'..'Z').to_a.each_with_index do |letter, index|
    eval("#{letter} = index")
  end

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
      next unless row.first =~ /\d+\/\d+\/\d+/
      rule_book[row[C..F].join(',')] ||= row[H]
    end
  end

  def each_row_with_object(filename, object)
    CSV.foreach(filename) do |row|
      yield row, object
    end

    object
  end

  attr_reader :input_filename, :output_filename
end
