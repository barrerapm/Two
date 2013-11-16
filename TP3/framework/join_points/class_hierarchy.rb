require_relative 'join_point'

class ClassHierarchy < JoinPoint

  def initialize(parametro_clase_padre)
    self.set_parametro_clase_padre(parametro_clase_padre)
  end

  def set_parametro_clase_padre(parametro_clase_padre)
    @parametro_clase_padre = parametro_clase_padre
  end

  def match?(clase, metodo)
    clase.ancestors.any? {|una_super_clase| una_super_clase.to_s == @parametro_clase_padre.to_s}
    end
  end
