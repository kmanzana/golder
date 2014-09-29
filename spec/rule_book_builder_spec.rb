require 'spec_helper'

describe 'RuleBookBuilder' do
  let(:out_filename) { './spec/support/actual_unique_test.yml' }

  let(:in_filenames) do
    ['./spec/support/unique_test.csv', './spec/support/unique_test_2.csv']
  end

  let(:builder) do
    RuleBookBuilder.new(input_filenames: in_filenames,
                        output_filename: out_filename)
  end

  describe '#initialize' do
    it 'should have the correct instance variables' do
      builder.instance_variable_get(:@input_filenames).should == in_filenames
      builder.instance_variable_get(:@output_filename).should == out_filename
    end
  end

  describe '#build' do
    let(:expected_output) do
      File.open('./spec/support/expected_unique_test.yml').read
    end

    let(:actual_output) { File.open(out_filename).read }

    before { builder.build }

    it 'produce the rule book correctly' do
      actual_output.should == expected_output
    end
  end
end
