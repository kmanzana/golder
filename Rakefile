task default: [:rule_book, :discrepancies]

task :rule_book do
  require './lib/lookup_key_generator'
  require './lib/tasks/rule_book_builder'

  RuleBookBuilder.new(
    input_filenames: Dir.glob('./lib/resources/reference_files/*\.csv'),
    output_filename: './lib/resources/bwon_rule_book.yml'
  ).build
end

task :discrepancies do
  require './lib/lookup_key_generator'
  require './lib/tasks/discrepancies'

  Discrepancies.new(
    input_filenames: Dir.glob('./lib/resources/reference_files/*\.csv'),
    output_filename: './lib/resources/discrepancies.csv'
  ).build
end
