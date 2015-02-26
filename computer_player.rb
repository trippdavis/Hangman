class ComputerPlayer
  attr_reader :secret_word
  attr_accessor :guessed

  def initialize(dictionary_file)
    @dictionary = File.readlines(dictionary_file).map(&:chomp)
    @guessed = []
  end

  def pick_secret_word
    @secret_word = @dictionary.sample
    @secret_word.length
  end

  def check_guess(guess)
    locations = []
    @secret_word.split("").each_with_index do |char, idx|
      locations << idx if char == guess
    end

    locations
  end

  def receive_secret_length(word_length)

  end

  def guess
    loop do
      guess = ("a".."z").to_a.sample
      unless @guessed.include?(guess)
        @guessed << guess
        return guess
      end
    end
  end

  def reveal_word
    @secret_word
  end
end
