class Operaciones

  def and(op_derecho)
    to_pointcut(__method__, op_derecho)
  end

  alias :& :and

  # TODO: ver si se puede arreglar esto (se repite 1 linea de codigo, el fin del mundo)
  # no repetir codigo aca seria dificil, ya se intento con un metodo __operacion__, pero despues
  # el __method__ devuelve :__operacion__ en lugar de :and, y __callee__ devuelve :& si fue llamado
  # con &, asi que eso romperia el polimorfismo y el alias (elegir uno de 2: o el alias o el polimorfismo)
  def or(op_derecho)
    to_pointcut(__method__, op_derecho)
  end

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
