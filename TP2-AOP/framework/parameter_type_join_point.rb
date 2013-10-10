require_relative '../framework/join_point'

class ParameterTypeJoinPoint < JoinPoint

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