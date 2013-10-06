class Condition

  attr_accessor :join_point, :negated

  def initialize(join_point, negated = false)
    @join_point = join_point
    @negated = negated
  end

  def aplica_join_point(clase, metodo)
    aplica_join_point = self.join_point.aplica?(clase, metodo)
    self.negated ? !aplica_join_point : aplica_join_point
  end

end

class ConditionAnd < Condition

  def evaluate(clase, metodo, result)
    result and aplica_join_point(clase, metodo)
  end

end

class ConditionOr < Condition

  def evaluate(clase, metodo, result)
    result or aplica_join_point(clase, metodo)
  end

end

