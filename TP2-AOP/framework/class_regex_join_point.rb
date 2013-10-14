require_relative '../framework/join_point'

class ClassRegexJoinPoint < JoinPoint

  def initialize(expresion_regular)
    self.set_regex(expresion_regular)
  end

  def set_regex(expresion_regular)
    @expresion_regular = expresion_regular
  end

  def aplica?(clase, metodo)
    (clase.to_s =~ @expresion_regular) != nil
  end

end