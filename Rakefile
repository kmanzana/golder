task default: [:build_rule_book]

task :build_rule_book do
  require './tasks/rule_book_builder'
  RuleBookBuilder.new('./resources/3Q13 BWON CD Report Final.csv').build
end
