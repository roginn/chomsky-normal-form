class TokenValidator

  delegate :string, :sanitized, :lhs, :rhs, :rhs_piped_derivations, to: :token_parser

  def initialize(token_parser)
    @token_parser = token_parser
  end

  def token_parser
    @token_parser
  end

  def check
    unless string.index TokenParser::DERIVATION_SYMBOL
      raise TokenValidationError.new "missing derivation symbol (->)"
    end

    if sanitized.split(TokenParser::DERIVATION_SYMBOL).size != 2
      raise TokenValidationError.new "expected 'LHS -> RHS'"
    end

    if lhs.index TokenParser::PIPE_SYMBOL
      raise TokenValidationError.new "LHS should not have a pipe symbol (|)"
    end

    if rhs.count(TokenParser::PIPE_SYMBOL) != rhs_piped_derivations.count - 1
      raise TokenValidationError.new "RHS should be of the form string1 [|string2 [|string3 [...] ] ]"
    end
  end

  class TokenValidationError < RuntimeError
    def initialize(msg)
      super "Malformed input string: #{msg}"
    end
  end
end
