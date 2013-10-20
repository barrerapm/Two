require_relative 'join_point'

class ClassRegex < JoinPoint

  def initialize(expresion_regular)
    self.set_regex(expresion_regular)
  end

  def set_regex(expresion_regular)
    @expresion_regular = expresion_regular
  end

  def match?(clase, metodo)
    (clase.to_s =~ @expresion_regular) != nil
  end

end