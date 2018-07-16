# This module remove special symbols from text
module LineCleaner
  SPECIAL_SYMBOLS = /[.,!?:;«»<>&'()] /

  def self.line_cleaner(battle_file_path)
    File.open("text/#{battle_file_path}", 'r').select do |line|
      line
    end.join(' ').downcase.gsub(SPECIAL_SYMBOLS, ' ').split
  end
end
