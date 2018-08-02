class Utils
  # escaping characters
  def self.escape_string(str)
    str.gsub(/[()"'*.-]/) { |sym| '\\' + sym }.chomp
  end

  # declension of words depending on the number
  def self.declension_words(num, words)
    # words[(num = (num = num % 100) > 19 ? (num % 10) : num) == 1 ? 0 : (num > 1 && num <= 4 ? 1 : 2)]
    cases = [2, 0, 1, 1, 1, 2]
    ind = num % 100 > 4 && num % 100 < 20 ? 2 : cases[[num % 10, 5].min]
    words[ind]
  end

  def self.rappers_list
    fh = open 'config/rapper_names'
    fh.map(&:rstrip)
  end
end
