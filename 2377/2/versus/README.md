# Versus Statistics Application
## Commands:
* `--top-bad-words=[number]`
Displays statistics of [number] rappers starting with the most foul-mouthed.
Statistics includes
  * amount of battles
  * amount of bad words
  * amount of words per battle
  * amount of words per round
* `--top-words=[number]` `--name=[name]`
  * Displays [number] of the most used words of rapper [name]. You can also use this command without `--top-words=[number]` parameter and top-30 the most used words will appear.

## Requirements
To work correctly place `*.rb` files in the directory with texts of battles. Name of file should match the following regular expression:  `/((\w|\d|.|\s)*?)(?=против|[vV][Ss] )/`. Each file should contain text of only one rapper. It can also be divided into rounds using `(\d [Рр]аунд)|([Рр]аунд \d)`.

## Use with pleasure   :sparkles:
