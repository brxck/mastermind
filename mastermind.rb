class Game
  def initialize
    @maker = Maker.new
    @breaker = Breaker.new
  end
end

class Code
  attr_reader :full_matches, :partial_matches
  def initialize(secret)
    @secret = secret
    @full_matches = 0
    @partial_matches = 0
  end

  # TODO: Move check to where code object is initialized
  def secret=(secret)
    @secret = @secret if @secret # Don't allow secret to be changed
    secret = secret.to_s
    @secret = secret if /\d{4}/.match(secret) && secret.length == 4
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

class Maker
  def initialize
    
  end

  def create_code

  end
end

class Breaker
  
end
