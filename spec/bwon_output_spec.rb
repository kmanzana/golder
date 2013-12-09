# rubocop:disable Void
require 'spec_helper'
# require 'tempfile'

describe 'BWONOutput' do
  before do
    raw_data_file.write "Suncor Waste Tracking Log V2,,,,,,,,,,,,\nCustomer: Suncor Energy USA- Denver Refinery,,,,,,,,,,,,\nStart Date: 9/1/2013 12:00:00 AM,,,,,,,,,,,,\nEnd Date: 10/1/2013 12:00:00 AM,,,,,,,,,,,,\nVacuum Truck Company,Shift Report Date,Offload Date,Time,Truck Number,Unit,Source,Material,Volume (BBL),Rough Est Water %,\"To Unit/ Discharge\nPoint\",Driver Name,Ticket\nPSC,09/01/2013,09/01/2013,13:00:00,LV-1,CRUDE DOCKS UNLOADING,CRUDE DOCKS - UNDERGROUND TANK - TANK 101,OILY WATER,60,99%,PLANT 1 - VAC PAD,H. Medina,T-ADE-3CF-5CFB\nPSC,09/02/2013,08/31/2013,07:00:00,LV-7,PLANT 1 - NORTH OF THE FENCELINE,P1 N – Sumps/Wells/Trenches (clean truck),OILY WATER,1.50,99%,PLANT 1 - VAC PAD,D. Schock,T-ADE-78D-B2FC\nPSC,09/02/2013,08/31/2013,08:00:00,LV-7,PLANT 1 - NORTH OF THE FENCELINE,P1 N – Tank 3 (clean truck),SLOP OIL,10,<10%,PLANT 2 - TANK 20,D. Schock,T-ADE-78D-B2FC\n"
    raw_data_file.rewind
  end

  after do
    raw_data_file.close
    raw_data_file.unlink    # deletes the temp file
  end

  let(:raw_data_file) { Tempfile.new('raw_data') }
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

    it 'should build the output as a string' do
      bwon_build_output.should be_instance_of(String)
    end

    it 'should produce the correct output' do
      bwon_build_output.should == '09/01/2013\n09/02/2013\n09/02/2013\n'
    end
  end

  describe '#copy_data' do
    let(:copy_data_output) { bwon.send(:copy_data, raw_data[5]) }

    it 'should return "Shift Report Date" (column B) from raw data file into column A' do
      copy_data_output[0].should == raw_data[5][1]
    end
  end

end

