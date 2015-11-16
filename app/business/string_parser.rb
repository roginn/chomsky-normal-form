class StringParser
  attr_reader :symbols

  def initialize(symbols)
    @symbols = symbols
  end

  def parse
    check_validation
    # TODO: this hurts my eyes
    if symbols[0].empty_symbol?
      EmptyString.new(symbols)
    else
      NonemptyString.new(symbols)
    end
  end

  protected
  def check_validation
    StringValidator.new(self).check
  end
end
