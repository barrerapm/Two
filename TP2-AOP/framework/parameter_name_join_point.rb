require_relative '../framework/join_point'

class ParameterNameJoinPoint < JoinPoint

  attr_accessor :boolean_value

  def initialize(metodo)
    @metodo = metodo
  end

  def tiene_este_parametro?(parametro)
    @metodo.parameters.select {|param| param[1] == parametro.to_sym}
  end

  #def aplica?(clase, metodo)
  #  return @metodo
  #end

end