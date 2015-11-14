class SymbolParser
  attr_reader :string

  EMPTY_STRING_SYMBOL = '_'

  def initialize(string)
    @string = string
  end

  def parse
    string.split('').map { |c| parse_character(c) }
  end

  protected
  def parse_character(c)
    case c
    when 'a'..'z'
      TerminalSymbol.new(c)
    when 'A'..'Z'
      NonterminalSymbol.new(c)
    when '_'
      EmptySymbol.new
    else
      raise SymbolValidationError.new "invalid character '#{c}'"
    end
  end

  class SymbolValidationError < RuntimeError
    def initialize(msg)
      super "Malformed symbol: #{msg}"
    end
  end
end
