class GrammarString
  attr_reader :symbols

  delegate :size, :[], :each, :all?, :any?, to: :symbols

  def initialize(symbols)
    @symbols = symbols
  end

  def to_s
    @symbols.map { |s| s.to_s }.join
  end

  def ==(other)
    self.to_s == other.to_s
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
