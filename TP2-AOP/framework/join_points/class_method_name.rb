require_relative 'join_point'

class Class_method_name < JoinPoint
  attr_accessor :metodo_buscado

  def initialize(metodo_a_buscar)
    @metodo_buscado = metodo_a_buscar
  end

  def match?(clase, metodo)
    clase.instance_methods(false).any? {|unMetodo| unMetodo.to_s == @metodo_buscado.to_s}
  end

end
