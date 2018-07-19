# Task 2
## Common description
The main task of this utility is to count 
filthy words in of participants of VERSUS battles. This utility can accept parametrs. During developing this app diffrent gems were used.
## Level 1
At the first level of this task, all filthy words of all battles are analyzed. Also, the number of battles, rounds, and all words of battle are counted. Algorithm of searching filthy words search all words that contain * symbol and check all words with [gem 'russian_obscenity'](github.com/oranmor/russian_obscenity).

User can send parametr `--top-bad-words=,<number>`, what will accepted by this utility and show <number> of battlers with the highest amount of filthy words.
Also you can use --help to watch how to use --top-bad-words parametr
As well, this app count number of battles and number of rounds of every participant.
For table output was used [gem 'terminal-table'](https://github.com/tj/terminal-table)

## Work example

ruby versus_battles.rb --top-bad-words=6

+--------------------------+------------+----------------------+----------------------+-------------------+
| Rickey F                 | 6 баттлов  | 395 нецензурных слов | 65.8 слов на баттл   | 877 слов в раунде |
| Леха Медь                | 3 баттлов  | 365 нецензурных слов | 121.7 слов на баттл  | 371 слов в раунде |
| Хип-хоп одинокой старухи | 3 баттлов  | 337 нецензурных слов | 112.3 слов на баттл  | 756 слов в раунде |
+--------------------------+------------+----------------------+----------------------+-------------------+


