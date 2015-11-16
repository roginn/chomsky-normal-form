module GrammarTransformations
  class NonsolitaryTerminals
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
      rule.rhs.select { |s| s.terminal_count > 0 and s.nonterminal_count > 0 }
    end

    def transform_rules
      @grammar.production_rules.each do |rule|
        if strings_to_be_fixed(rule).any?
          transform_rule rule
        end
      end
    end

    def transform_rule(rule)
      to_be_deleted = []
      strings_to_be_fixed(rule).each do |string|
        to_be_deleted << string
        rule.rhs << transform_string(string)
      end

      to_be_deleted.each { |s| rule.rhs.delete s }
    end

    def transform_string(string)
      new_symbols = []
      string.symbols.each do |symbol|
        if symbol.terminal?
          new_derivation = create_derivation(symbol)
          new_symbols << new_derivation.lhs
        else
          new_symbols << symbol
        end
      end

      NonemptyString.new new_symbols
    end

    def taken_lhs_names
      @grammar.compute_rule_map
      @grammar.lhs_symbols.keys
    end

    def create_derivation(terminal)
      unless @new_derivations.has_key? terminal.to_s
        nonterminal_name = SymbolNameGenerator.new.nonterminal taken_lhs_names
        nonterminal      = NonterminalSymbol.new nonterminal_name
        string           = NonemptyString.new [terminal]
        rule             = ProductionRule.new nonterminal, [string]
        @new_derivations[terminal.to_s] = rule
        @grammar.production_rules << rule
      end

      @new_derivations[terminal.to_s]
    end
  end
end
