require_relative '../framework/join_point'

class ClassJoinPoint < JoinPoint

  def initialize(parametro_clase)
    self.set_parametro_clase(parametro_clase)
  end

  def set_parametro_clase(parametro_clase)
    @parametro_clase = parametro_clase.to_s

  end

  def aplica?(clase, metodo)
    clase.to_s == @parametro_clase
  end

end