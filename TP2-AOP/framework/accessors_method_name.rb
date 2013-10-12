require_relative '../framework/join_point'

class accessors_method_name < join_point

  def tieneEstaVariableConEsteMetodo (unaClase, unMetodo)
    unaClase.instance_variable_get(unMetodo)
  end

  def aplica?(clase, metodo)
    self.tieneEstaVariableConEsteMetodo(unaclase, unMetodo) || self.tieneEstaVariableConEsteMetodo(unaclase, unMetodo + '=')
  end

end