class GrammarString
  attr_reader :symbols

  def initialize(symbols)
    @symbols = symbols
  end

  def nonterminal_count
    @symbols.select { |s| !s.terminal? }.count
  end

  def terminal_count
    @symbols.select { |s| s.terminal? }.count
  end

  def empty_string?
    false
  end
end
