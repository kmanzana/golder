# rubocop:disable Void
require 'spec_helper'

describe 'RuleBookBuilder' do
  let(:in_filename)  { './spec/support/unique_test.csv' }
  let(:out_filename) { './spec/support/actual_unique_test.yml' }
  let(:builder) { RuleBookBuilder.new(in_filename, out_filename) }

  describe '#initialize' do
    it 'should have the correct instance variables' do
      builder.instance_variable_get(:@input_filename).should == in_filename
      builder.instance_variable_get(:@output_filename).should == out_filename
    end
  end

  describe '#build' do
    let(:expected_output) do
      File.open('./spec/support/expected_unique_test.yml').read
    end

    let(:actual_output) { File.open(out_filename).read }

    before do
      builder.build
    end

    it 'produce the rule book correctly' do
      actual_output.should == expected_output
    end
  end
end
