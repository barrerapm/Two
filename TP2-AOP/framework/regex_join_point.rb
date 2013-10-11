require_relative '../framework/join_point'

class RegexJoinPoint < JoinPoint

  def initialize(expresion_regular)
    self.set_regex(expresion_regular)
  end

  def set_regex(expresion_regular)
    @expresion_regular = expresion_regular
  end

  def aplica?(clase, metodo)
    if clase != nil
      (clase.to_s =~ @expresion_regular) != nil
    else
      (metodo.to_s =~ @expresion_regular) != nil
    end
  end

end