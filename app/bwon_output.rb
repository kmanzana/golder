require 'csv'
require 'yaml'

class BWONOutput
  include LookupKeyGenerator

  ASSOCIATIONS = YAML.load_file('./lib/resources/associations.yml')
  RULE_BOOK    = YAML.load_file('./lib/resources/bwon_rule_book.yml')
  LOOKUP_COLUMNS = [G, H, I, N, Q, R, X, Y]

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
    CSV.generate do |output_csv|
      each_raw_data_row do |raw_data_row|
        output_csv << get_data(raw_data_row)
      end
    end
  end

  private

  attr_reader :raw_data_file, :current_row

  def each_raw_data_row
    CSV.foreach(raw_data_file) do |row|
      next unless row[A] == 'PSC'
      next if row[B..M].index(nil)
      yield row
    end
  end

  def get_data(input_data)
    @current_row = copy_data(input_data)

    add_lookup_data! unless key_doesnt_exist?
    add_copied_calculated_data!

    current_row
  end

  def add_lookup_data!
    LOOKUP_COLUMNS.each do |col|
      @current_row[col] = RULE_BOOK[lookup_key(current_row)][col]
    end

    add_lookup_calculated_data!
  end

  def add_lookup_calculated_data!
    both_are_no = @current_row[G] == 'NO' && @current_row[I] == 'NO'

    @current_row[J] = both_are_no ? 'YES' : 'NO'
    @current_row[U] = calculate_u_percentage(@current_row[N])
    @current_row[AB] = @current_row[N].to_f >= 0.1 ? 'YES' : 'NO'

  end

  def add_copied_calculated_data!
    @current_row[L] = @current_row[K].to_f * 42
  end

  def copy_data(input_data)
    ASSOCIATIONS.each_with_object([]) do |col_pair, output_data|
      output_col, input_col = col_pair.map { |e| self.class.const_get(e) }
      input_value = input_data[input_col].gsub(DASH, HYPHEN)

      output_data[output_col] = handle_division(input_value, input_col)
    end
  end

  def key_doesnt_exist?
    unless RULE_BOOK[lookup_key(current_row)]
      @current_row[0] = "ERROR! #{@current_row[0]}"
    end
  end

  def calculate_u_percentage(value)
    "#{(100 - value.to_f).round}%"
  end

  def handle_division(value, column)
    if column == I && value =~ /\//
      divide(value)
    else
      value
    end
  end

  def divide(value)
    numbers = value.split('/').map(&:to_f)
    numbers[0] / numbers[1]
  end
end
