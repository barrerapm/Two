require_relative 'join_point'

class ClassJP < JoinPoint

  def initialize(parametro_clase)
    self.set_parametro_clase(parametro_clase)
  end

  def set_parametro_clase(parametro_clase)
    @parametro_clase = parametro_clase.to_s
  end

  def match?(clase, metodo)
    clase.to_s == @parametro_clase
  end

end