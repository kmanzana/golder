require 'csv'

class BWONOutput
  def initialize(raw_data_file)
    @raw_data_file = raw_data_file
  end

  def build
    CSV.generate do |csv_output_row|
      each_raw_data_row do |raw_data_row|
        csv_output_row << copy_data(raw_data_row)
        # csv_output_row << lookup_data
      end
    end
  end

  private

  def each_raw_data_row
    CSV.foreach(raw_data_file) do |row|
      next unless row.first == 'PSC'
      yield row
    end
  end

  def copy_data(row)
    [row[1]]
  end

  def lookup_data
  end

  attr_reader :raw_data_file
end
