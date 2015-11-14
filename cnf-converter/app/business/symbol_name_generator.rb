class SymbolNameGenerator
  def initialize
  end

  def nonterminal(restrictions = [])
    generate ('A'..'Z').to_a, restrictions
  end

  def terminal(restrictions = [])
    generate ('a'..'z').to_a, restrictions
  end

  protected
  def generate(base, restrictions)
    options = base - restrictions
    if options.any?
      options.first
    else
      iterate_for_glory base.first, restrictions
    end
  end

  def iterate_for_glory(first_letter, restrictions)
    i = 0
    while "#{first_letter}#{i}".in? restrictions do
      i += 1
    end
    "#{first_letter}#{i}"
  end
end
