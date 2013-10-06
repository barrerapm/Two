require_relative 'conditions/condition'

class PointCut

  attr_accessor :conditions

  def initialize
    @conditions = Array.new
  end

  def aplica?(clase, metodo)
    result = true
    @conditions.each do
      |condition|
      result = condition.evaluate(clase, metodo, result)
    end
    result
  end

end
