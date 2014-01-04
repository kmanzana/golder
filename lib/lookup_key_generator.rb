module LookupKeyGenerator
  DASH   = '–'
  HYPHEN = '-'

  ('A'..'Z').to_a.each_with_index do |letter, index|
    const_set(letter, index)
  end

  def lookup_key(row)
    row[C..F].join(';').gsub(/\s+/, '').gsub(DASH, HYPHEN).upcase
  end
end
