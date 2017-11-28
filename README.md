# mastermind

This is a solution for the [The Odin Project: OOP.](https://www.theodinproject.com/courses/ruby-programming/lessons/oop)

Commandline implementation of the board game [Mastermind.](https://www.wikiwand.com/en/Mastermind_(board_game))

## Usage

```
$ ruby mastermind.rb
Will you be the (1) Codebreaker? or the (2) Codemaker?
> 1
Guess four digits:
> 1234
X O O
Guess four digits:
> 1235
X O
Guess four digits:
> 5234
X O
Guess four digits:
> 1634
X X O O
Guess four digits:
> 1643
X O O O
Guess four digits:
> 4631
You won! It was 4631.
```


## Planning

- class Game
  - class Maker
  - class Breaker
  - class Code

- Options: default
  - Number of turns: 12
  - Number of games: 4
  - Length of code: 4
  - Number of code pieces: 6 
