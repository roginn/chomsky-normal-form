module GrammarTransformations
  class NonsolitaryTerminals
    def initialize(grammar)
      @grammar = grammar
    end

    def transformed
      rules_to_fix = []
      grammar.production_rules.each do |rule|
        if rule.rhs.any? { |string| string.terminal_count > 0 and string.nonterminal_count > 0 }
          rules_to_fix << rule
        end
      end
      grammar.deep_dup
    end
  end
end
