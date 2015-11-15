module GrammarTransformations
  class UnitRules
    def initialize(grammar)
      @grammar = grammar
    end

    def transformed
      @grammar.deep_dup
    end
  end
end
