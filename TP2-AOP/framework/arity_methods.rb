require_relative '../framework/join_point'
require_relative '../framework/regex_join_point'

class arity_methods < RegexJoinPoint

  def initialize(expresion_regular)
    super.initialize(expresion_regular)     #una posible expresion regular seria '> 3'
  end

  def aridad (unMetodo)
    unMetodo.arity.abs
  end

  def aplica?(unaClase, unMetodo)
    clase.instance_methods(false).any? {|unMetodo| unMetodo.aridad.expresion_regular}
  end

end