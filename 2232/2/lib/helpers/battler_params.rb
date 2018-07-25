module BattlerParams
  ROUND_IN_BATTLE = 3

  def self.average_curses(curses, battles)
    (curses.to_f / battles).round(2)
  end

  def self.counting_curses(texts)
    change_text = RussianObscenity.sanitize(texts.join(' '), '<CR>')
    change_text.scan('<CR>').size + change_text.count('*')
  end

  def self.average_words(texts)
    texts.join(' ').split.size / (ROUND_IN_BATTLE * texts.size)
  end
end
