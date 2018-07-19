CURSE_WORDS_DICT = File.read('curse_words').split(' ')
CURSE_WORDS_REGEX = Regexp.new("(\\W#{CURSE_WORDS_DICT
    .join('\W|\W')}|\\W[а-яА-Я]*\\*+[а-яА-Я]*\\W)")
NAMES_REGEX = /^.+?(?='?(а|a|ы)?\s+(против|vs))/i
NO_DIRECTORY = %(
Warning: Not found "texts" directory.
Create "texts" directory and put there files with battles texts.
).freeze
ALL_COMMAND_INFO = %(
- Command for search bad words --top-bad-words=<<number>>
- Command for search favorite words --top-words=<<number>> --name=<<name>>
).freeze
BAD_WORD_COMMAND_INFO = %(
To start search bad words use command --top-bad-words=<<number>>
).freeze
FAVORITE_WORDS_INFO = %(
Command for search favorite words --top-words=<<number>> --name=<<name>>
).freeze
TOO_MANY_ARGS = "Too many arguments \n" + ALL_COMMAND_INFO
