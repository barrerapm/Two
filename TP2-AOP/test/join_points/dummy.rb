require_relative '../../framework/join_points/join_point'

class Dummy < JoinPoint

  attr_accessor :boolean_value

  def initialize(boolean_value)
    @boolean_value = boolean_value
  end

  def match?(clase, metodo)
     return @boolean_value
  end

end