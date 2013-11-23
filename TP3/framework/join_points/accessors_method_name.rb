require_relative 'join_point'

class AccessorsMethodName < JoinPoint

  def es_metodo_accessor(metodo)
    metodo.to_s.end_with?("=")
  end

  def match?(clase, metodo)
    filtrados = clase.instance_methods(false)
    filtrados.include?(metodo) && es_metodo_accessor(metodo)
  end

end