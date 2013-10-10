require_relative '../framework/join_point'

class ParameterTypeJoinPoint < JoinPoint

  def initialize(tipo_de_parametro)
    self.set_tipo_de_parametro(tipo_de_parametro)
  end

  def set_tipo_de_parametro(tipo_de_parametro)
    @tipo_de_parametro = tipo_de_parametro
  end

  def aplica?(clase, metodo)
    metodo.parameters.select {|param| param[0] == @tipo_de_parametro}
  end

end