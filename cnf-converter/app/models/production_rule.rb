class ProductionRule
  attr_reader :rhs, :lhs

  def initialize(lhs, rhs)
    raise RuntimeError.new('LHS should be a nonterminal') unless lhs.is_a? NonterminalSymbol
    raise RuntimeError.new('RHS should be a grammar string') unless rhs.is_a? GrammarString
    @lhs, @rhs = lhs, rhs
  end
end
