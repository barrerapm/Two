require_relative 'join_point'

class AccessorsMethodName < JoinPoint

  def tieneEstaVariableConEsteMetodo (unaClase, unMetodo)
    unaClase.instance_variable_get(unMetodo)
  end

  def aplica?(clase, metodo)
    self.tieneEstaVariableConEsteMetodo(unaclase, unMetodo) || self.tieneEstaVariableConEsteMetodo(unaclase, unMetodo + '=')
  end

end