require_relative 'join_point'

class Custom < JoinPoint

  attr_accessor :bloque

  def initialize(&bloque)
    @bloque = bloque
  end

  def match?(clase, metodo)
    bloque.call clase, metodo
  end

end