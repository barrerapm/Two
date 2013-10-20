require_relative 'operaciones'

class JoinPoint < Operaciones

  def match?(clase, metodo)
    raise 'JoinPoint no implementado: no se definio el metodo match?(Class clase, Symbol metodo)'
  end

end