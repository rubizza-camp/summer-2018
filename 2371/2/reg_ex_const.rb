CURSE_WORDS_DICT = File.read('curse_words').split(' ')
CURSE_WORDS_REGEX = Regexp.new("(\\W#{CURSE_WORDS_DICT
    .join('\W|\W')}|\\W[а-яА-Я]*\\*+[а-яА-Я]*\\W)")
NAMES_REGEX = /^.+?(?='?(а|a|ы)?\s+(против|vs))/i
