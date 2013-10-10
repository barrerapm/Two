require_relative '../framework/join_point'

class ParameterNameJoinPoint < JoinPoint

  def initialize(nombre_de_parametro)
    self.set_parametro(nombre_de_parametro)
  end

  def set_parametro(nombre_de_parametro)
    @nombre_de_parametro = nombre_de_parametro
  end

  def aplica?(clase, metodo)
    metodo.parameters.select {|param| param[1] == @nombre_de_parametro}
  end

end