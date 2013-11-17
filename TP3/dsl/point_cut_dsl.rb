require 'set'

base = '../framework'

require_array = [
    'framework_aop',
    #'join_points/class_name_2',
    #'join_points/method_name_2',
    #'join_points/parameter_name_2',
    'join_points/method_regex',
    'join_points/class_regex',
    'join_points/arity_methods',
    'join_points/pointcut',
    #'join_points/pointcut_bonus',
    #'join_points/joinpoint_bonus',
]
require_array.each {|rb| require_relative base + '/' + rb}

class PointCutDSL

  attr_accessor :point_cut

  def expresion_regular(comparator)
    @point_cut =  comparator.regex_point_cut
  end

  def aridad(comparator)
    @point_cut = comparator.arity_point_cut
  end

  def clase(compare_obj)
    ClassComparator.new(compare_obj)
  end

  def metodo(compare_obj)
    MethodComparator.new(compare_obj)
  end

  def es(compare_with)
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

end

class ClassComparator < Comparator

  def regex_point_cut
    ClassRegex.new(@compare_obj.value_to_compare)
  end

end

class MethodComparator  < Comparator

  def regex_point_cut
    MethodRegex.new(@compare_obj.value_to_compare)
  end

  def arity_point_cut
    Arity_methods.new(@compare_obj.value_to_compare)
  end

end

class EqualsCompare

  attr_accessor :value_to_compare

  def initialize(compare_with)
    @value_to_compare = compare_with
  end

end