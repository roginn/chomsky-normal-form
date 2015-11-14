class ProductionRuleValidator

  delegate :lhs, :rhs, to: :production_rule_parser

  def initialize(production_rule_parser)
    @production_rule_parser = production_rule_parser
  end

  def production_rule_parser
    @production_rule_parser
  end

  def check
    unless lhs.is_a? NonterminalSymbol
      raise ProductionRuleValidationError.new 'LHS should be a nonterminal symbol'
    end

    unless rhs.is_a? Array and rhs.all? { |e| e.is_a? GrammarString }
      raise RuntimeError.new 'Internal Error: RHS should be an array of grammar strings'
    end
  end

  class ProductionRuleValidationError < RuntimeError
    def initialize(msg)
      super "Malformed production rule: #{msg}"
    end
  end
end
