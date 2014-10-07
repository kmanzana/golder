require 'yaml'

module LookupKeyGenerator
  DASH   = '–'
  HYPHEN = '-'
  LOOKUP_COLUMNS_ARRAY = YAML.load_file('./lib/resources/lookup_columns.yml')

  ('A'..'AB').to_a.each_with_index do |letter, index|
    const_set(letter, index)
  end

  LOOKUP_COLUMNS = LOOKUP_COLUMNS_ARRAY.map { |col| self.const_get(col) }

  def lookup_key(row)
    row[C..F].join(';').gsub(/\s+/, '').gsub(DASH, HYPHEN).upcase
  end
end
