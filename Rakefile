task default: [:build_rule_book]

task :build_rule_book do
  require './lib/csv_helper'
  require './lib/tasks/rule_book_builder'
  RuleBookBuilder.new('./lib/resources/3Q13 BWON CD Report Final.csv',
                      './lib/resources/bwon_rule_book.yml')
  .build

  # RuleBookBuilder.build('./lib/resources/bwon_rule_book.yml') do |rule_book|
  #   rule_book.with('./lib/resources/3Q13 BWON CD Report Final.csv')
  # end
end
