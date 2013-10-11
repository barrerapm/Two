require_relative '../framework/join_point'

class CustomJoinPoint < JoinPoint

  attr_accessor :bloque

  def initialize(&bloque)
    @bloque = bloque
  end

  def aplica?(clase, metodo)
    bloque.call metodo
  end

end