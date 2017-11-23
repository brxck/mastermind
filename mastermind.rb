class Game
  attr_reader :maker, :breaker, :code

  def initialize
    @maker = Maker.new
    @breaker = Breaker.new
    @code = Code.new
  end
end

class Code
  def initialize
    @full_matches = 0
    @partial_matches = 0
  end

  def secret=(secret)
    secret = secret.to_s
    if /\d{4}/.match(secret) && secret.length == 4
      @secret = secret
    else
      false
    end
  end

  def check_guess(guess)
    if guess == secret
      true
    else
      find_matches(guess)
    end
  end

  def find_matches(guess)
    @full_matches = 0
    @partial_matches = 0
    unmatched = @secret.split("")
    guess.split("").each_with_index do |digit, guess_index|
      if (secret_index = unmatched.find_index(digit))
        unmatched.delete_at(secret_index)
        guess_index == secret_index ? @full_matches += 1 : @partial_matches += 1
      end
    end
  end
end

class Maker
  def initialize

  end

  def create_code

  end
end

class Breaker
  
end

game = Game.new