require_relative '../framework/join_point'

class ParameterNameJoinPoint < JoinPoint

  attr_accessor :nombre_de_parametro

  def initialize(nombre_de_parametro)
    @nombre_de_parametro = nombre_de_parametro
  end

  def matchNombreParametros(metodo)
    metodo.parameters.select {|param| param[1] == nombre_de_parametro}
  end

  def aplica?(clase, metodo)
    matchNombreParametros(metodo).empty?
  end

end