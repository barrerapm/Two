require_relative '../framework/join_point'

class DummyJoinPoint < JoinPoint

  attr_accessor :boolean_value

  def initialize(boolean_value)
    @boolean_value = boolean_value
  end

  def aplica?(clase, metodo)
     return @boolean_value
  end

end