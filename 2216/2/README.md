# Rap Battles

A console utility that accepts various arguments for analyzing the texts of various participants in rap battles

# Scope

With this utility you can

  - Find out the most obscene participant
  - Find for a specific member of his favorite words in battles

### Instruction

To run the utility, you must enter a command `$ ruby versus.rb` with parameters `--top-bad-words`, `--name` , `--top-words`.

To search for obscene participants, use the `--top-bad-words option`, which shows the maximum number of users that should be displayed.

```sh
$ ruby versus.rb --top-bad-words=3
```
To search for favorite words in battles for a particular participant, you must pass its name through the parameter `--name`. To limit the output, use the `--top-words` option:

```sh
$ ruby versus.rb --top-words=5 --name=Oxxymiron
```
