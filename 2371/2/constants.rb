CURSE_WORDS_DICT = File.read('curse_words').split(' ')

NO_DIRECTORY_ERROR = %(
Error: No such file or directory "./texts/".
Create "./texts" directory and put there files with battles texts.
).freeze

ALL_COMMAND_INFO = %(
- Command for search bad words --top-bad-words=<<number>>
- Command for search favorite words --top-words=<<number>> --name=<<name>>
).freeze

BAD_WORDS_ERROR = %(
Error: Incorrect command.
Command for search bad words --top-bad-words=<<number>>
).freeze

FAV_WORDS_ERROR = %(
Error: Incorrect command.
Command for search favorite words --top-words=<<number>> --name=<<name>>
).freeze

NO_AUTHORS = 'No authors found'.freeze

NO_CONTENT_WARN = 'Warning: No content found'.freeze
