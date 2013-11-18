require_relative 'join_point'

class ParameterName < JoinPoint

  attr_accessor :nombre_de_parametro

  def initialize(nombre_de_parametro)
    @nombre_de_parametro = nombre_de_parametro
  end

  def match_nombre_parametros(clase, metodo)
    clase.instance_method(metodo).parameters.select {|param| param[1] == nombre_de_parametro}
  end

  def match?(clase, metodo)
    not match_nombre_parametros(clase, metodo).empty?
  end

end
