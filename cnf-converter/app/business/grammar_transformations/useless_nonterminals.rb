module GrammarTransformations
  class UselessNonterminals
    def initialize(grammar)
      @grammar = grammar
    end

    def transformed
      @grammar.deep_dup
    end
  end
end
