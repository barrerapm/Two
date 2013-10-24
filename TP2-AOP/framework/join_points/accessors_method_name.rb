require_relative 'join_point'

class AccessorsMethodName < JoinPoint

  def match?(clase, metodo)
    objeto = clase.new
    clase.instance_methods(false).any? do |unMetodo|
      objeto.instance_eval  do
        puts unMetodo.to_s
        if unMetodo.to_s.end_with?("=")
          variable_string = "@#{unMetodo}" - "="
        else
           variable_string = "@#{unMetodo}"
        end
        defined?(variable_string.to_sym)
      end
    end
  end
end
