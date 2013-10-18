require_relative 'join_point'

class ParameterType < JoinPoint

  attr_accessor :tipo_de_parametro

  def initialize(tipo_de_parametro)
    @tipo_de_parametro = tipo_de_parametro
  end

  def matchTipoParametros(metodo)
    metodo.parameters.select {|param| param[0] == tipo_de_parametro}
  end

  def aplica?(clase, metodo)
    not matchTipoParametros(metodo).empty?
  end

end