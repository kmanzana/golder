require 'spec_helper'

describe 'RuleBookBuilder' do
  let(:builder) do
    RuleBookBuilder.new(File.join(File.dirname(__FILE__),
                                  '/support/unique_test.csv'))
  end

  describe '#initialize' do

    it 'should have an input filename instance variable' do
      builder.instance_variable_get(:@input_filename).should ==
        '/Users/kmanzanares/Projects/golder/spec/support/unique_test.csv'
    end
  end

  describe '#build' do
    let(:expected_output) do
      File.open(File.join(File.dirname(__FILE__),
                          '/support/expected_unique_test.yml')).read
    end

    let(:actual_output) do
      File.open(File.join(File.expand_path('.'),
                          '/lib/resources/actual_unique_test.yml')).read
    end

    before do
      builder.build
    end

    it 'produce the rule book correctly' do
      actual_output.should == expected_output
    end
  end
end
