require_relative 'operaciones'

class Pointcut < Operaciones
  attr_accessor :op_izquierdo, :op_derecho, :operador, :array_clases

  def initialize(op_izquierdo, operador, op_derecho)
    @op_izquierdo = op_izquierdo
    @operador = operador
    @op_derecho = op_derecho
    @operaciones = {:and=>:interseccion, :or=>:union, :not=>:complemento}
  end

  def match
    if @operador == :not then  # esta distincion es porque not es de aridad 1
      send(@operaciones[@operador], @op_izquierdo.match)
    else    # aca podria poner 1 millon de operadores binarios si tuviese ganas
      send(@operaciones[@operador], @op_izquierdo.match, @op_derecho.match)
    end
  end

  # NOTA: se puede usar el mensaje & entre 2 Array y entre 2 Set, y funca del modo esperado en ambos casos
  def interseccion(op_izq, op_der)
    op_izq & op_der   # ese & es el mensaje (interseccion) entre arrays, no confundir con los & entre JPs y PCs
  end

  # NOTA: se puede usar el mensaje | entre 2 Array y entre 2 Set, y funca del modo esperado en ambos casos
  def union(op_izq, op_der)
    op_izq | op_der   # ese | es el mensaje (union) entre arrays, no confundir con los | entre JPs y PCs
  end

  # NOTA: se puede usar el mensaje - entre 2 Array y entre 2 Set, y funca del modo esperado en ambos casos
  def complemento(op)
    array_clases.to_set - op   # ese - es el mensaje (sustraccion) entre 2 Set
  end

  def match?(clase, metodo)
    if @operador == :not then  # esta distincion es porque not es de aridad 1
      send(@operaciones[@operador], @op_izquierdo.match?(clase, metodo))
    else    # aca podria poner 1 millon de operadores binarios si tuviese ganas
      send(@operaciones[@operador], @op_izquierdo.match?(clase, metodo), @op_derecho.match?(clase, metodo))
    end
  end

end
