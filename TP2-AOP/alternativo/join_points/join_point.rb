=begin

REGLAS
------

#  Tres operaciones (and, or, not): &, |, ~

#  Cualquier operacion entre JPs devuelve un nuevo PC
jp1 & jp2 => Pointcut
jp1 | jp2 => Pointcut
~jp1 => Pointcut

#  Operaciones entre PCs son validas y devuelven otro PC
pc1 & pc2 => Pointcut

#  Asi se van construyendo multiples operaciones entre JPs y/o PCs
pc1 = jp1 & jp2
#  pc1 ahora tiene esto: jp1 & jp2
pc2 = pc1 | jp3
#  pc2 ahora tiene esto: (jp1 & jp2) | jp3
pc3 = ~pc2
#  pc3 ahora tiene esto: ~( (jp1 & jp2) | jp3 )

#  Ejemplo: se quiere que un PC matchee las clases que empiezan con "Hola" (regex)
#           y "dentro" de ese match, matchear los metodos que terminen con "bueno"
jp1 = ClassRegexMatchJoinPoint.new('/^Hola.*/')
jp2 = MethodRegexMatchJoinPoint.new('/.*bueno/')
pc1 = jp1 & jp2
pc2 = jp2 & jp1
# notar que & es conmutativo, si se parte desde el ObjectSpace usando 1ro jp1 o 1ro jp2, da el mismo resultado
pc3 = ClassRegexMatchJoinPoint.new('/^Hola.*/') & jp2
# se los puede usar como uno quiera

#  Ejemplo:
#    PC que matchee los metodos que terminen con "bueno" y que tengan aridad 4 y que
#    al menos uno de sus parametros se llame "pepe", o que el tipo de parametro sea opcional
jp1 = MethodRegexMatchJoinPoint.new('/.*bueno/')
jp2 = MethodArityJoinPoint.new(4)
jp3 = ParameterNameJoinPoint.new(:pepe)
jp4 = ParameterTypeJoinPoint.new(:opt)
pc1 = jp1 & jp2 & (jp3 | jp4)

#  Ejemplo:
#    PC que de el mismo resultado que el original, si es negado 2 veces
pc1 = MethodArityJoinPoint.new(4)
pc2 = ~~pc1
# aca pc1 y pc2 deberian dar el mismo resultado (mismos matches)

=end


# TODO: ver donde queda mejor dejar este hash para las 3 operaciones
class Ops

  def Ops.operacion
    {:and=>Ops.interseccion, :or=>Ops.union, :not=>Ops.complemento}
  end

  # TODO: terminar de codear las 3 operaciones entre enums de clases
  def interseccion(op_izq, op_der)
    # TODO: ya esta interseccion y union pero solo para el nivel de clases, falta lo mismo pero para metodos y parametros
    resultado = op_izq & op_der
    #op_izq
  end

  def union(op_izq, op_der)
    op_izq | op_der
  end

  # TODO: aca se necesita acceder al array_clases del framework para poder hacer
  def complemento(op)
    #array_clases - op
  end

end


# TODO: implementar and, or, not en clases Joinpoint y Pointcut
class Joinpoint

  def and(op_derecho)
    to_pointcut(__method__, op_derecho)
  end

  # TODO: ver si se puede arreglar esto (se repite 1 linea de codigo, el fin del mundo)
  # no repetir codigo aca seria dificil, ya se intento con un metodo __operacion__, pero despues
  # el __method__ devuelve :__operacion__ en lugar de :and, y __callee__ devuelve :& si fue llamado
  # con &, asi que eso romperia el polimorfismo y el alias (elegir uno de 2: o el alias o el polimorfismo)
  def or(op_derecho)
    to_pointcut(__method__, op_derecho)
  end

  def not
    to_pointcut(__method__)
  end

  def to_pointcut(operador, op_derecho=nil)  # el nil es para cuando el operador es not
    Pointcut.new(self, operador, op_derecho)
  end

  def match
    # IMPLEMENTARLO EN CADA SUBCLASE!!!
    raise 'ESTA USTED LOCO???  LLAMO AL METODO DE LA SUPERCLASE.  REDEFINALO YA!!'
  end

end

# esto hay que hacerlo en una "redefinicion" de Joinpoint porque en la primer definicion el alias
# no conoce al metodo que se desea "copiar"
# esto es solo para tener sintaxis magica
class Joinpoint
  alias :& :and
  alias :| :or
  alias :~ :not
end


class Pointcut
  attr_accessor :op_izquierdo, :op_derecho, :operador

  def initialize(op_izquierdo, operador, op_derecho)
    @op_izquierdo = op_izquierdo
    @operador = operador
    @op_derecho = op_derecho
  end

  def match
    p 'op', @operador
    if @operador == :not then
      Ops.operacion[@operador].call(@op_izquierdo.match)
    else
      Ops.operacion[@operador].call(@op_izquierdo.match, @op_derecho.match)
    end
  end

end
