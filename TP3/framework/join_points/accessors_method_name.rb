require_relative 'join_point'

class AccessorsMethodName < JoinPoint

  def es_metodo_accessor(clase, metodo)
    objeto = clase.new
    if metodo.to_s.end_with?("=")
      cadena_variable = metodo.to_s[0, metodo.to_s.length - 1]
    else
      cadena_variable = metodo.to_s
    end
    objeto.instance_variable_defined?("@#{cadena_variable}")
  end

  def match?(clase, metodo)
    filtrados = clase.instance_methods(false)
    filtrados.include?(metodo) && es_metodo_accessor(clase, metodo)
  end

end