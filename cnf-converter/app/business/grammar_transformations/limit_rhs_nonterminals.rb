module GrammarTransformations
  class LimitRhsNonterminals
    def initialize(grammar)
      @grammar = grammar.deep_dup
      @new_derivations = {}
    end

    def transformed
      transform_rules
      @grammar
    end

    protected
    def strings_to_be_fixed(rule)
      rule.rhs.select { |s| s.nonterminal_count > 2 }
    end

    def transform_rules
      @grammar.production_rules.each do |rule|
        if strings_to_be_fixed(rule).any?
          transform_rule rule
        end
      end
    end

    def transform_rule(rule)
      strings_to_be_fixed(rule).each do |string|
        rule.rhs.delete string
        rule.rhs << transform_string(string)
      end
    end

    def transform_string(string)
      new_symbols = []
      string = string.deep_dup
      first_symbol = string.symbols.first
      string.symbols.delete first_symbol
      new_derivation = create_derivation(string)
      new_nonterminal = new_derivation.lhs
      NonemptyString.new [first_symbol, new_nonterminal]
    end

    def taken_lhs_names
      @grammar.compute_rule_map
      @grammar.all_nonterminals.to_a
    end

    def create_derivation(string)
      unless @new_derivations.has_key? string.to_s
        nonterminal_name = SymbolNameGenerator.new.nonterminal taken_lhs_names
        nonterminal      = NonterminalSymbol.new nonterminal_name
        rule             = ProductionRule.new nonterminal, [string]
        @new_derivations[string.to_s] = rule
        @grammar.production_rules << rule
      end

      @new_derivations[string.to_s]
    end
  end
end
