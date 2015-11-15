module GrammarTransformations
  class InitialSymbol
    def initialize(grammar)
      @grammar = grammar
    end

    def transformed
      start_symbol = grammar.start_symbol
      new_first_symbol = GrammarSymbol.new('S0')
      new_first_string = GrammarString.new([start_symbol])
      new_first_rule = ProductionRule.new(new_first_symbol, [new_first_string])
      Grammar.new([new_first_rule] + grammar.production_rules)
    end
  end
end
