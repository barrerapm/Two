class Operaciones

  # NOTA: en este TP3 se pudo hacer que los metodos and / or sean un alias del metodo
  #       __operacion_binaria__, se repite menos logica, ahora hay 1 unico punto de error
  def __operacion_binaria__(op_derecho)
    to_pointcut(__callee__, op_derecho)
  end

  alias :and :__operacion_binaria__
  alias :or :__operacion_binaria__

  alias :& :and
  alias :| :or

  def not
    to_pointcut(__method__)
  end

  alias :~ :not

  def to_pointcut(operador, op_derecho=nil)  # el nil es para cuando el operador es not
    pc = Pointcut.new(self, operador, op_derecho)
    pc.array_clases = @array_clases
    pc
  end

end
