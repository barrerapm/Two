require_relative 'join_point'

class ParameterName < JoinPoint

  attr_accessor :simbolo_parametro

  def initialize(nombre_de_parametro)
    @simbolo_parametro = nombre_de_parametro
  end

  def match_nombre_parametros(clase, metodo)
    clase.instance_method(metodo).parameters.select do |param| param[1] == simbolo_parametro end
  end

  def match?(clase, metodo)
    not match_nombre_parametros(clase, metodo).empty?
  end

end