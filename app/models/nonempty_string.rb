class NonemptyString < GrammarString
  def deep_dup
    NonemptyString.new @symbols.dup
  end
end
