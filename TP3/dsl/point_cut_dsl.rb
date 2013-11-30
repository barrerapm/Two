require 'set'

base = '../framework'

require_array = [
    'framework_aop',
    #'join_points/class_name_2',
    #'join_points/method_name_2',
    #'join_points/parameter_name_2',
    'join_points/class_jp',
    'join_points/class_regex',
    'join_points/class_hierarchy',
    'join_points/class_method_name',
    'join_points/method_regex',
    'join_points/accessors_method_name',
    'join_points/arity_methods',
    'join_points/parameter_name',
    'join_points/parameter_type',
    'join_points/custom',
    #'join_points/pointcut',
]
require_array.each {|rb| require_relative base + '/' + rb}

class PointCutDSL

  attr_accessor :point_cut

  def accessors
    @point_cut = AccessorsMethodName.new
  end

  def join_point(&bloque)
    @point_cut = Custom.new(&bloque)
  end

  def aridad(comparator)
    @point_cut = comparator.arity_point_cut
  end

  def jerarquia(comparator)
    @point_cut = comparator.hierarchy_point_cut
  end

  def clase(compare_obj)
    @comparator = ClassComparator.new(compare_obj)
    @point_cut = @comparator.point_cut_es
    @comparator
  end

  def metodo(compare_obj)
    @comparator = MethodComparator.new(compare_obj)
    @point_cut = @comparator.point_cut_es
    @comparator
  end

  def tipo(compare_obj)
    @comparator = TypeComparator.new(compare_obj)
    @point_cut = @comparator.parameter_point_cut
    @comparator
  end

  def parametro(comparator)
    @point_cut = comparator.parameter_point_cut
  end

  def es(compare_with)
    EqualsCompare.new(compare_with)
  end

  def pertenece(compare_with)
    EqualsCompare.new(compare_with)
  end

  def build_point_cut
    @point_cut
  end

end

class Comparator

  def initialize(compare_obj)
    @compare_obj = compare_obj
  end

  def point_cut_es
    if(@compare_obj.value_to_compare.class == Regexp)
      point_cut_es_regex
    else
      point_cut_es_exact
    end
  end

end

class ClassComparator < Comparator

  def point_cut_es_regex
    ClassRegex.new(@compare_obj.value_to_compare)
  end

  def point_cut_es_exact
    ClassJP.new(@compare_obj.value_to_compare)
  end

  def hierarchy_point_cut
    ClassHierarchy.new(@compare_obj.value_to_compare)
  end

end

class MethodComparator  < Comparator

  def point_cut_es_regex
    MethodRegex.new(@compare_obj.value_to_compare)
  end

  def arity_point_cut
    Arity_methods.new(@compare_obj.value_to_compare)
  end

  def parameter_point_cut
    ParameterName.new(@compare_obj.value_to_compare)
  end

  def point_cut_es_exact
    Class_method_name.new(@compare_obj.value_to_compare)
  end

end

class TypeComparator < Comparator
  def parameter_point_cut
    ParameterType.new(@compare_obj.value_to_compare)
  end
end

class EqualsCompare

  attr_accessor :value_to_compare

  def initialize(compare_with)
    @value_to_compare = compare_with
  end

end