require 'spec_helper'

describe 'BWONOutput' do
  let(:raw_data_file) { File.open('./spec/support/raw_data.csv') }
  let(:raw_data) { CSV.parse(raw_data_file.read) }
  let(:bwon) { BWONOutput.new(raw_data_file) }

  describe '#new' do
    it 'should make instance variables and assign correctly' do
      bwon.should be_instance_of(BWONOutput)
      bwon.instance_variable_get(:@raw_data_file).should == raw_data_file
    end
  end

  describe '#build' do
    let(:bwon_build_output) { bwon.build }
    let(:expected_bwon_output) do
      File.open('./spec/support/expected_bwon_output.csv').read
    end

    it 'should build the output as a string' do
      bwon_build_output.should be_instance_of(String)
    end

    it 'should produce the correct output' do
      bwon_build_output.should == expected_bwon_output
    end
  end

  describe '#download_filename' do
    context 'if filename has a month' do
      let(:upload_filename) { 'November Suncor Waste Tracking Log V2.csv' }
      filename_month = 'November Suncor Vacuum Truck Movements.csv'
      let(:filename_month) { filename_month }

      it "should have the filename #{filename_month}" do
        bwon.download_filename(upload_filename).should eq(filename_month)
      end
    end

    context 'if filename does not have a month' do
      let(:upload_filename) { 'Suncor Waste Tracking Log V2.csv' }
      filename_no_month = 'Monthly Suncor Vacuum Truck Movements.csv'
      let(:filename_no_month) { filename_no_month }

      it "should have the filename #{filename_no_month}" do
        bwon.download_filename(upload_filename).should eq(filename_no_month)
      end
    end
  end

  describe 'private methods, delete if these fail later' do
    describe '#calculate_u_percentage' do
      it 'should use the equation to find a percentage value' do
        bwon.send(:calculate_u_percentage, '90%').should eq '10%'
        bwon.send(:calculate_u_percentage, '95.5%').should eq '5%'
        bwon.send(:calculate_u_percentage, '99%').should eq '1%'
      end
    end
  end
end
