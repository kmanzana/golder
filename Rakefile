task default: [:build_rule_book]

task :build_rule_book do
  require './lib/csv_helper'
  require './lib/tasks/rule_book_builder'
  RuleBookBuilder.new('./lib/resources/3Q13 BWON CD Report Final.csv',
                      './lib/resources/bwon_rule_book.yml')
  .build
end
