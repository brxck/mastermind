class Game
  def initialize
    @code = Code.new
    @computer = Computer.new
    @player = Player.new

    start_game
  end

  def start_game
    # TODO: choose codemaker/breaker
    @code.secret = @computer.create_code
  end

  def player_guess
    print "Guess: "
    guess = gets.chomp
    if code.check_guess(guess)
      puts "You won!"
    else
      draw_matches
    end
  end

  def draw_matches
    output = []
    code.full_matches.times { output << "X" }
    code.partial_matches.times { output << "O" }
    puts output.join(" ")
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
  end

  class Code
    attr_reader :full_matches, :partial_matches
     def initialize
      @full_matches = 0
      @partial_matches = 0
    end
  
    def secret=(secret)
      @secret = @secret if @secret # Don't allow secret to be changed
      secret = secret.to_s
      @secret = secret if /\[1-6]{4}/.match(secret) && secret.length == 4
    end
  
    def check_guess(guess)
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
  end

  class Player
    def initialize
      @turns = 12
    end
  end
end