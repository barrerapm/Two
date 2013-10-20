require_relative 'operaciones'
require_relative 'pointcut'


class Joinpoint < Operaciones

  def match
    # IMPLEMENTARLO EN CADA SUBCLASE!!!
    raise 'ESTA USTED LOCO???  LLAMO AL METODO DE LA SUPERCLASE.  REDEFINALO YA!!'
  end

  def reconstruir(lista)
    self
  end

end
