require 'csv'

class BWONOutput
  INPUT_HEADERS =  [:vacuum_truck_company,
                    :shift_report_date,
                    :offload_date,
                    :time,
                    :truck_number,
                    :unit,
                    :source,
                    :material,
                    :volume_bbl,
                    :rough_est_water,
                    :to_unit_discharge_point,
                    :driver_name,
                    :ticket]

  OUTPUT_HEADERS = [:date,
                    :vacuum_truck_number,
                    :unit,
                    :vacuum_truck_movement_description,
                    :vacuum_truck_material_description,
                    :offload_sitewaste_destination, nil, nil, nil, nil,
                    :total_waste_quantity_bbls, nil,
                    :vac_truck_log_water_content]

  ASSOCIATED_HEADERS = {
    date:                               :shift_report_date,
    vacuum_truck_number:                :truck_number,
    unit:                               :unit,
    vacuum_truck_movement_description:  :source,
    vacuum_truck_material_description:  :material,
    offload_sitewaste_destination:      :to_unit_discharge_point,
    total_waste_quantity_bbls:          :volume_bbl,
    vac_truck_log_water_content:        :rough_est_water
  }

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
        output_csv << copy_data(raw_data_row)
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
