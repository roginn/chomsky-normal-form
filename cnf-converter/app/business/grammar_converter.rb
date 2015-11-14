class GrammarConverter
  attr_reader :grammar

  STEPS = [
    :initial_symbol,
    :nonsolitary_terminals,
    :limit_rhs_nonterminals,
    :nullable_rules,
    :unit_rules,
    :useless_nonterminals
  ]

  def initialize(grammar)
    @grammar = grammar
  end

  def call_step(number, *args)
    public_send STEPS[number], *args
  end

  def steps_results
    (0..(STEPS.size-1)).inject([@grammar]) do |acc, step_number|
      grammar = acc.last
      acc << call_step(step_number, grammar)
    end
  end

  def initial_symbol(grammar)
    start_symbol = grammar.start_symbol
    new_first_symbol = GrammarSymbol.new('S0')
    new_first_string = GrammarString.new([start_symbol])
    new_first_rule = ProductionRule.new(new_first_symbol, [new_first_string])
    Grammar.new([new_first_rule] + grammar.production_rules)
  end

  def nonsolitary_terminals(grammar)
    grammar.deep_dup
  end

  def limit_rhs_nonterminals(grammar)
    grammar.deep_dup
  end

  def nullable_rules(grammar)
    grammar.deep_dup
  end

  def unit_rules(grammar)
    grammar.deep_dup
  end

  def useless_nonterminals(grammar)
    grammar.deep_dup
  end

end
