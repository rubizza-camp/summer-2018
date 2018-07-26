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

Run **run.rb** with command **--top-bad-words="number"**

#### Example

  ```sh
$ ruby run.rb --top-bad-words=7
```
#### Outputs

| rickey f                 | 6 батлов  | 389 нецензурных слов | 64.83 слова на баттл  | 3591.0 слова в раунде |
| леха медь                | 3 батлов  | 363 нецензурных слов | 121.00 слова на баттл | 3866.0 слова в раунде |
| oxxxymiron               | 6 батлов  | 221 нецензурных слов | 36.83 слова на баттл  | 5768.0 слова в раунде |
| эмио афишл               | 2 батлов  | 207 нецензурных слов | 103.50 слова на баттл | 1847.0 слова в раунде |
| st                       | 10 батлов | 205 нецензурных слов | 20.50 слова на баттл  | 4431.0 слова в раунде |
| гнойный                  | 3 батлов  | 201 нецензурных слов | 67.00 слова на баттл  | 1909.0 слова в раунде |
| хип-хоп одинокой старухи | 1 батлов  | 192 нецензурных слов | 192.00 слова на баттл | 1019.0 слова в раунде |
| drago                    | 6 батлов  | 192 нецензурных слов | 32.00 слова на баттл  | 3484.0 слова в раунде |
| букер                    | 4 батлов  | 190 нецензурных слов | 47.50 слова на баттл  | 2364.0 слова в раунде |
| эрнесто заткнитесь       | 5 батлов  | 165 нецензурных слов | 33.00 слова на баттл  | 3904.0 слова в раунде |
