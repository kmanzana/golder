class RuleBookBuilder
  def initialize(input_filename)
    @input_filename = input_filename
  end

  def build
    output_filename = File.join(File.dirname(__FILE__),
                                '../resources/bwon_rule_book.yml')

    File.open(output_filename, 'w+') do |file|
      file << rule_book_hash.to_yaml
    end
  end

  private

  def rule_book_hash
    each_row_with_object(input_filename, {}) do |row, rule_book|
      next unless row.first == 'PSC'

      rule_book[row[0..3].join(', ')] ||= row[4..5]
    end
  end

  def each_row_with_object(filename, object)
    CSV.foreach(filename) do |row|
      yield row, object
    end

    object
  end

  attr_reader :input_filename
end
