# Task 2
## Common description
The main task of this utility is to count 
filthy words in of participants of VERSUS battles. This utility can accept parametrs. During developing this app diffrent gems were used.
## Level 1
At the first level of this task, all filthy words of all battles are analyzed. Also, the number of battles, rounds, and all words of battle are counted. Algorithm of searching filthy words.

# Prepare

  - Install Depencies
  ```sh
$ gem install terminal-table
```
  - Create folder **texts** in root of project 
  - Add battles text files to folder **texts**
 
# Run Project

Run **application.rb** with command **--top-bad-words="number"**

#### Example

  ```sh
$ ruby curse_words_searcher.rb --top-bad-words=7
```
#### Outputs

| rickey f   | 6 батлов  | 422 нецензурных слов | 70.33 слова на баттл  | 3591.0 слова в раунде |
| леха медь  | 3 батлов  | 378 нецензурных слов | 126.00 слова на баттл | 3866.0 слова в раунде |
| oxxxymiron | 6 батлов  | 288 нецензурных слов | 48.00 слова на баттл  | 5768.0 слова в раунде |
| st         | 10 батлов | 258 нецензурных слов | 25.80 слова на баттл  | 4431.0 слова в раунде |
| drago      | 6 батлов  | 225 нецензурных слов | 37.50 слова на баттл  | 3484.0 слова в раунде |
| гнойный    | 3 батлов  | 224 нецензурных слов | 74.67 слова на баттл  | 1909.0 слова в раунде |
| эмио афишл | 2 батлов  | 209 нецензурных слов | 104.50 слова на баттл | 1847.0 слова в раунде |
