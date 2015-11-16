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
    step_class = STEPS[number].to_s.camelize
    GrammarTransformations.const_get(step_class).new(*args).transformed
  end

  def results
    (0..(STEPS.size-1)).inject([@grammar]) do |acc, step_number|
      grammar = acc.last
      acc << call_step(step_number, grammar)
    end
  end
end
