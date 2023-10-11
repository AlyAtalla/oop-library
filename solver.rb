class Solver
  def self.factorial(n)
    if n < 0
      raise ArgumentError, 'Factorial is not defined for negative numbers'
    end
    result = 1
    (1..n).each { |i| result *= i }
    result
  end
  def self.reverse(word)
    word.reverse
  end
  def self.fizzbuzz(n)
    if n % 3 == 0 && n % 5 == 0
      'fizzbuzz'
    elsif n % 3 == 0
      'fizz'
    elsif n % 5 == 0
      'buzz'
    else
      n.to_s
    end
  end
end
