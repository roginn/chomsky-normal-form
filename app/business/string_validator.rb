class StringValidator

  delegate :symbols, to: :string_parser

  def initialize(string_parser)
    @string_parser = string_parser
  end

  def string_parser
    @string_parser
  end

  def check
    unless symbols.is_a? Array
      raise RuntimeError.new "Internal error: string should be an array of symbols"
    end

    if symbols.select { |s| s.is_a? EmptySymbol }.present? and symbols.size > 1
      raise StringValidationError.new "empty strings should not be concatenated"
    end
  end

  class StringValidationError < RuntimeError
    def initialize(msg)
      super "Malformed grammar string: #{msg}"
    end
  end
end
