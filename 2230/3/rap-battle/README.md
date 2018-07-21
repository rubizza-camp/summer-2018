### Описание

Программа создана для анализа некоторых текстов участников рэп-баттлов VERSUS.

### Установка

1. Клонируйте или скачайте файлы проекта
2. Зайдите в папку проекта и закачайте данные для анализа
`./load_data.sh`

### Первый запуск
Выполните в каталоге проекта:
```bash
bundle
ruby rap-battle --help
```

### Функциональность

Программа способна проанализировать все тексты и выяснить самого нецензурного участника площадки.

Параметр `--top-bad-words`, который передается в программу, показывает максимальное количество самых нецензурных участников, которое следует вывести на экран.

Дополнительно будет посчитано общее количество баттлов для каждого участника и среднее количество всех слов в раунде.