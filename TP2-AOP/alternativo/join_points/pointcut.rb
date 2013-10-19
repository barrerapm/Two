class Pointcut
  attr_accessor :op_izquierdo, :op_derecho, :operador

  def initialize(op_izquierdo, operador, op_derecho)
    @op_izquierdo = op_izquierdo
    @operador = operador
    @op_derecho = op_derecho
    @operaciones = {:and=>:interseccion, :or=>:union, :not=>:complemento}
  end

  def match
    #p 'op', @operador
    if @operador == :not then  # esta distincion es porque not es de aridad 1
      @operaciones[@operador].call(@op_izquierdo.match)
    else    # aca podria poner 1 millon de operadores binarios si tuviese ganas
      @operaciones[@operador].call(@op_izquierdo.match, @op_derecho.match)
    end
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
