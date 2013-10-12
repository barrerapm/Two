require_relative '../framework/join_point'

class class_method_name < join_point

  def aplica?(clase, metodo)
    clase.instance_methods(false).any? {|unMetodo| unMetodo.to_s == metodo.to_s}
  end

end