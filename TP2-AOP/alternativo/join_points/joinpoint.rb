require_relative 'operaciones'
require_relative 'pointcut'


class Joinpoint < Operaciones

  def match
    # IMPLEMENTARLO EN CADA SUBCLASE!!!
    raise 'ESTA USTED LOCO???  LLAMO AL METODO DE LA SUPERCLASE.  REDEFINALO YA!!'
  end

  # NOTA: ignoren este metodo! No se usa! Era parte de un BONUS que quise hacer, capaz despues lo termino
  def reconstruir(lista)
    self
  end

end
