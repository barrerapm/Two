require_relative 'join_point'

class AccessorsMethodName < JoinPoint

  def match?(clase, metodo)
    clase.instance_methods(false).any? do |unMetodo|
       es_metodo_accessor(clase, unMetodo)
    end
  end
end

def es_metodo_accessor(clase, metodo)
  objeto = clase.new
  if metodo.to_s.end_with?("=")
    cadena_variable = metodo.to_s[0, metodo.to_s.length - 1]
  else
    cadena_variable = metodo.to_s
  end
  objeto.instance_variable_defined?("@#{cadena_variable}")
end
