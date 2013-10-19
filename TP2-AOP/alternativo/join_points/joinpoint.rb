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



