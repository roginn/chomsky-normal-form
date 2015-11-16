module GrammarTransformations
  class UnitRules
    def initialize(grammar)
      @grammar = grammar.deep_dup
    end

    def transformed
      handle_unit_rules
      @grammar
    end

    protected
    def handle_unit_rules
      begin
        found_unit_rule = false
        # puts "GRAMMAR NOW LOOKS LIKE THIS:"
        # puts @grammar.to_s
        @grammar.production_rules.each do |rule|
          if has_unit_derivation?(rule)
            # puts "RULE HAS UNIT DERIVATION:"
            # puts rule.to_s
            found_unit_rule = true
            remove_unit_derivations rule
          end
        end
      end while found_unit_rule
    end

    def has_unit_derivation?(rule)
      unit_derivations(rule).any?
    end

    def unit_derivations(rule)
      rule.rhs.select do |s|
        s.size == 1 and s.nonterminal_count == 1 and !s.empty_string?
      end
    end

    def remove_unit_derivations(rule)
      pivot_nonterminal = rule.lhs.to_s
      derivations_to_be_appended = []
      nonterminals_to_be_removed = []

      unit_derivations(rule).each do |string|
        nonterminal = string.symbols[0]
        nonterminals_to_be_removed << nonterminal.to_s
        @grammar.derived_by(nonterminal).each do |unit_rule|
          derivations_to_be_appended += unit_rule.rhs
        end
      end

      derivations_to_be_appended.each do |string|
        label = string.to_s
        unless label.in? rule.rhs or label.in? nonterminals_to_be_removed or label == pivot_nonterminal
          rule.rhs << string
        end
      end

      nonterminals_to_be_removed.each do |symbol|
        rule.rhs.reject! { |s| s.to_s == symbol.to_s }
      end
      # puts "NONTERMINALS TO BE REMOVED:"
      # puts nonterminals_to_be_removed.to_s
      # puts "DERIVATIONS TO BE APPENDED:"
      # puts derivations_to_be_appended.map(&:to_s).join("\n")
    end
  end
end
