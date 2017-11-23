class Game
  def initialize
    @code = Code.new
    @computer = Computer.new
    @player = Player.new
    @maker_bot = true
    @turns = 12
  end

  def play
    @code.secret = @computer.create_code
    loop do
      guess = @maker_bot ? @player.guess : @computer.guess
      if @code.check(guess) == true
        win
        break
      elsif @turns.zero?
        lose
        break
      end
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

    def create_code
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
      @secret = @secret if @secret # Don't allow secret to be changed
      secret = secret.to_s
      @secret = secret if /[1-6]{4}/.match(secret) && secret.length == 4
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
  end
end

game = Game.new
game.play
