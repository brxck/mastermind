# TODO: add AI

class Game
  def initialize
    @code = Code.new
    @computer = Computer.new
    @player = Player.new
    @maker_bot = true
    @turns = 12
  end

  def start
    choose_role
    play ? win : lose
  end

  def choose_role
    puts "Will you be the (1) Codebreaker? or the (2) Codemaker?"
    input = gets.chomp
    if input == "1"
      @maker_bot = true
      @code.secret = @computer.create_secret
    elsif input == "2"
      @maker_bot = false
      loop do
        @code.secret = @player.prompt
        break if @code.secret
      end
      puts "Code is #{@code.secret}"
    end
  end

  def play
    loop do
      guess = @maker_bot ? @player.guess : @computer.guess
      if @code.check(guess) == true
        return true
      elsif @turns.zero?
        return false
      end
      @turns -= 1
      @code.draw_matches
    end
  end

  def win
    puts "You won! It was #{@code.secret}."
  end

  def lose
    puts "You lost!"
  end

  class Computer
    attr_reader :maker

    def initialize(maker_switch = true)
      @maker_bot = maker_switch
    end

    def create_secret
      secret = ""
      4.times { secret += rand(1..6).to_s }
      secret
    end

    def guess
      guess = ""
      4.times { guess += rand(1..6).to_s }
      guess
    end
  end

  class Code
    attr_reader :full_matches, :partial_matches, :secret

    def initialize
      @full_matches = 0
      @partial_matches = 0
    end

    def secret=(secret)
      secret = secret.to_s
      if !@secret && /[1-6]{4}/.match(secret) && secret.length == 4
        @secret = secret.to_s
      end
    end

    def check(guess)
      if guess == @secret
        true
      else
        find_matches(guess)
      end
    end

    def find_matches(guess)
      @full_matches = @partial_matches = 0
      unmatched = @secret.split("")
      guess.split("").each_with_index do |digit, guess_index|
        if (secret_index = unmatched.find_index(digit))
          unmatched[secret_index] = ""
          guess_index == secret_index ? @full_matches += 1 : @partial_matches += 1
        end
      end
    end

    def draw_matches
      output = []
      @full_matches.times { output << "X" }
      @partial_matches.times { output << "O" }
      puts output.join(" ")
    end
  end

  class Player
    def guess
      puts "Guess four digits:"
      gets.chomp[0..3]
    end

    def prompt
      puts "Input four-digit secret code."
      gets.chomp
    end
  end
end

loop do
  game = Game.new
  game.start
end
