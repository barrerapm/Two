require_relative 'join_point'

class Arity_methods < JoinPoint

  attr_accessor :rango

  def initialize(rango_dado)
    @rango = rango_dado
  end

  def aridad(unaClase, unMetodo)
     unaClase.instance_method(unMetodo).arity
  end

  def match?(unaClase, unMetodo)
    filtrados = unaClase.instance_methods(false)

    (filtrados.include?(unMetodo)) && @rango.to_a.include?(aridad(unaClase, unMetodo))
  end

end
