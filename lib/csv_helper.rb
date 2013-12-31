module CSVHelper
  WANT_TO_KILL_MYSELF_DASH = '–'
  GOOD_DASH                = '-'

  ('A'..'Z').to_a.each_with_index do |letter, index|
    eval("#{letter} = index")
  end

  def lookup_key(row)
    get_rid_of_pesky_dashes(row[C..F].join(';').gsub(/\s+/, '').upcase)
  end

  def get_rid_of_pesky_dashes(string)
    string.gsub(WANT_TO_KILL_MYSELF_DASH, GOOD_DASH)
  end
end
