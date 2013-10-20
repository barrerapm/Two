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

  def interseccion(op_izq, op_der)
    # TODO: matchear metodos y parametros
    op_izq & op_der
  end

  def union(op_izq, op_der)
    op_izq | op_der
  end

  def complemento(op)
    array_clases.to_set - op
  end

end
