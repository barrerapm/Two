require_relative 'join_point'

class Custom < JoinPoint

  attr_accessor :bloque

  def initialize(&bloque)
    @bloque = bloque
  end

  def aplica?(clase, metodo)
    bloque.call metodo
  end

end