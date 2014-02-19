require 'yaml'

module LookupKeyGenerator
  DASH   = '–'
  HYPHEN = '-'

  ('A'..'AB').to_a.each_with_index do |letter, index|
    const_set(letter, index)
  end

  LOOKUP_COLUMNS =
    YAML.load_file('./lib/resources/lookup_columns.yml').map do |col|
      self.const_get(col)
    end

  def lookup_key(row)
    row[C..F].join(';').gsub(/\s+/, '').gsub(DASH, HYPHEN).upcase
  end
end
