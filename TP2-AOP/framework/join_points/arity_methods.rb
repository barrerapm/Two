require_relative 'join_point'

class Arity_methods

  attr_accessor :rango

  def initialize(rango_dado)
    @rango = rango_dado
  end

  def aridad(unaClase, unMetodo)
     obj = unaClase.new
    obj.method(unMetodo).arity
  end

  def match?(unaClase, unMetodo)
    unaClase.instance_methods(false).any? do
      |metodo|  @rango.to_a.include?(aridad(unaClase, metodo))
    end
  end

end
