require_relative 'join_point'

class ParameterName < JoinPoint

  attr_accessor :nombre_de_parametro

  def initialize(nombre_de_parametro)
    @nombre_de_parametro = nombre_de_parametro
  end

  def match_nombre_parametros(clase, metodo)
    clase.instance_method(metodo).parameters.select {|param| param[1] == nombre_de_parametro}
  end

  def match?(clase, metodo_symbol)
    not match_nombre_parametros(clase, clase.instance_method(metodo_symbol)).empty?
  end

end
