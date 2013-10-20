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

  # NOTA: ignoren este metodo! No se usa! Era parte de un BONUS que quise hacer, capaz despues lo termino
  def reconstruir(string)
    if @operador == :not then  # esta distincion es porque not es de aridad 1
      if op_izquierdo.class == Pointcut then
        string << "#{@operador} ("
      else
        string << "#{@operador} (#{@op_izquierdo.reconstruir(string)})"
      end
    else     # para and y or
      if op_izquierdo.class == Pointcut then
        #@op_izquierdo.reconstruir(string)
        string << "( #{@operador} #{@op_derecho.reconstruir(string)})"
      else
        string << "(#{@op_izquierdo.reconstruir(string)} #{@operador} #{@op_derecho.reconstruir(string)})"
      end
    end
    self
  end

  # NOTA: ignoren este metodo! No se usa! Era parte de un BONUS que quise hacer, capaz despues lo termino
  def to_string
    s = ''
    reconstruir(s)
    s
  end

end
