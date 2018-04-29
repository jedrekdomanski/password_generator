require "password_generator/version"

module PasswordGenerator
  ASCII = ('!'..'~')
  ALPHA = ASCII.grep(/[[:alpha:]]/)
  UPPER = ASCII.grep(/[[:upper:]]/)
  LOWER = ASCII.grep(/[[:lower:]]/)
  DIGIT = ASCII.grep(/[[:digit:]]/)
  PUNCT = ASCII.grep(/[[:punct:]]/)

  def self.generate(unique: false, punct: 0, digit: 0, upper: nil, length: 20)
    rest = length - punct - digit - upper.to_i
    if upper
      default_sampler = Sampler.new(LOWER, unique, rest)
    else
      default_sampler = Sampler.new(ALPHA, unique, rest)
    end
    punct_sampler = Sampler.new(PUNCT, unique, punct)
    digit_sampler = Sampler.new(DIGIT, unique, digit)
    upper_sampler = Sampler.new(UPPER, unique, upper.to_i)
    [default_sampler, punct_sampler, digit_sampler, upper_sampler].map do |sampler|
      sampler.sample
    end.flatten.shuffle.join
  end

  class Sampler
    def initialize(ary, unique, count)
      @ary, @unique = ary.dup, unique
      @count = count
    end

    def sample
      (1..@count).map do
        if @unique
          @ary.delete_at(rand(@ary.size))
        else
          @ary.sample
        end
      end
    end
  end
end

