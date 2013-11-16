require_relative '../framework/join_points/method_regex'
require_relative '../framework/join_points/class_regex'

class PointCutDSL

  attr_accessor :point_cut

  def expresion_regular(comparator)
    @point_cut =  comparator.regex_point_cut
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
    ClassRegex.new(@compare_obj)
  end

end

class MethodComparator  < Comparator

  def regex_point_cut
    MethodRegex.new(@compare_obj.value_to_compare)
  end

end

class EqualsCompare

  attr_accessor :value_to_compare

  def initialize(compare_with)
    @value_to_compare = compare_with
  end

end