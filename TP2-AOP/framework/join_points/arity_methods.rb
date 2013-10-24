require_relative 'join_point'

class Arity_methods

  attr_accessor :rango

  def initialize(rango_dado)
    @rango = rango_dado
  end

  def aridad(unMetodo)
    bloque = proc {unMetodo.to_sym}
    bloque.arity
  end

  def match?(unaClase, unMetodo)
    unaClase.instance_methods(false).any? do
      |metodo|  @rango.to_a.include?(aridad(metodo))
    end
  end

  def imprimir (unaClase)
    unaClase.instance_methods(false).each do
      |metodo, *arg| puts '-' + metodo.to_s
    end
  end

end
