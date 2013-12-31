require 'csv'
require 'yaml'

class BWONOutput
  INPUT_HEADERS = YAML.load_file('./lib/resources/input_headers.yml')
  OUTPUT_HEADERS = YAML.load_file('./lib/resources/output_headers.yml')
  ASSOCIATED_HEADERS = YAML.load_file('./lib/resources/associated_headers.yml')
  F_TO_H = YAML.load_file('./lib/resources/f_to_h.yml')

  def initialize(raw_data_file)
    @raw_data_file = raw_data_file
  end

  def download_filename(upload_filename)
    upload_first_word = upload_filename.split.first
    download_first_word =
      upload_first_word =~ /suncor/i ? 'Monthly' : upload_first_word.capitalize

    "#{download_first_word} Suncor Vacuum Truck Movements.csv"
  end

  def build
    CSV.generate(headers: OUTPUT_HEADERS, write_headers: true) do |output_csv|
      each_raw_data_row do |raw_data_row|
        output_csv << get_data(raw_data_row)
      end
    end
  end

  private

  attr_reader :raw_data_file

  def each_raw_data_row
    CSV.foreach(raw_data_file, headers: INPUT_HEADERS) do |row|
      next unless row[:vacuum_truck_company] == 'PSC'
      yield row
    end
  end

  def get_data(input_data)
    @current_hash = copy_data(input_data)
    lookup_data!

    @current_hash
  end

  def lookup_data!
    @current_hash[:destination_benzene_control_description] = F_TO_H[
      @current_hash[:offload_sitewaste_destination]
    ]
  end

  def copy_data(input_data)
    ASSOCIATED_HEADERS.each_with_object({}) do |header_pair, output_data|
      output_header, input_header = header_pair
      input_value = input_data[input_header]

      output_data[output_header] = handle_division(input_value, input_header)
    end
  end

  def handle_division(value, header)
    if header == :volume_bbl && value =~ /\//
      divide(value)
    else
      value
    end
  end

  def divide(value)
    numbers = value.split('/').map { |i| i.to_f }
    numbers[0] / numbers[1]
  end
end
