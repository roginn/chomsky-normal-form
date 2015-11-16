class EmptyString < GrammarString
  def empty_string?
    true
  end

  def deep_dup
    EmptyString.new @symbols.dup
  end
end
