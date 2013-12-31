require 'spec_helper'

describe 'RuleBookBuilder' do
  let(:input_filename)  { './spec/support/unique_test.csv' }
  let(:output_filename) { './spec/support/actual_unique_test.yml' }
  let(:builder) { RuleBookBuilder.new(input_filename, output_filename) }

  describe '#initialize' do
    it 'should have the correct instance variables' do
      builder.instance_variable_get(:@input_filename).should == input_filename
      builder.instance_variable_get(:@output_filename).should == output_filename
    end
  end

  describe '#build' do
    let(:expected_output) do
      File.open('./spec/support/expected_unique_test.yml').read
    end

    let(:actual_output) { File.open(output_filename).read }

    before do
      builder.build
    end

    it 'produce the rule book correctly' do
      actual_output.should == expected_output
    end
  end
end
