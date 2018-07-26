Raper statistic programm contains 3 options to enter:
1) --top-bad-words=value  (value should be a number of rapers about whom you want so see statistics)
Usage:
```
ruby versus.rb --top-bad-words=3

Гнойный    | 12 батлов | 127 нецензурных слов | 10.58 слова на баттл | 232 слова в раунде |
Oxxxymiron | 7 батлов  | 24 нецензурных слова | 3.42 слова на баттл  | 317 слов в раунде  |
Галат      | 3 батла   | 2 нецензурных слов   | 0.66 слова на баттл  | 207 слов в раунде  |
```

2) --top-words=value --name=name ('value' should be a number of the most used words by raper you want to see, 'name' is name of the raper)
Usage:
```
ruby versus.rb --top-words=20 --name=Толик

Рэпер Толик не известен мне. Зато мне известны:
Гнойный
Oxxxymiron
Галат
...

ruby versus.rb --top-words=5 --name=Oxxymiron

Факты - 5 раз
Папочку - 2 раза
Микрофоны - 1 раз
Птички - 1 раз
Пожертвую - 1 раз
```