class TokenParser
  attr_reader :string

  DERIVATION_SYMBOL = '->'
  PIPE_SYMBOL = '|'

  def initialize(string)
    @string = string
  end

  def sanitized
    @string.split(' ').join
  end

  def lhs
    sanitized.split(DERIVATION_SYMBOL).first
  end

  def rhs
    sanitized.split(DERIVATION_SYMBOL).last
  end

  def rhs_piped_derivations
    rhs.split(PIPE_SYMBOL).reject(&:empty?)
  end

  def check_validation
    TokenValidator.new(self).check
  end

  def parse
    check_validation
    [lhs, rhs_piped_derivations]
  end
end
