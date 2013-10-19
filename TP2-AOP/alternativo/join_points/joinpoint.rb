require_relative 'operaciones'


# TODO: implementar and, or, not en clases Joinpoint y Pointcut
class Joinpoint < Operaciones

  def to_pointcut(operador, op_derecho=nil)  # el nil es para cuando el operador es not
    Pointcut.new(self, operador, op_derecho)
  end

  def match
    # IMPLEMENTARLO EN CADA SUBCLASE!!!
    raise 'ESTA USTED LOCO???  LLAMO AL METODO DE LA SUPERCLASE.  REDEFINALO YA!!'
  end

end
