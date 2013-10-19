#require_relative 'conditions/condition'

class PointCut

  def initialize
    @conditions = Array.new
  end

  def and(join_point)
    old_result = self.method(:aplica?)
    self.send :define_singleton_method, :aplica? do
    |clase, metodo|
      old_result.call(clase, metodo) anda join_point.aplica?(clase, metodo)
    end
  end

  def or(join_point)
    old_result = self.method(:aplica?)
    self.send :define_singleton_method, :aplica? do
    |clase, metodo|
      old_result.call(clase, metodo) or join_point.aplica?(clase, metodo)
    end
  end

  def and_not(join_point)
    old_result = self.method(:aplica?)
    self.send :define_singleton_method, :aplica? do
    |clase, metodo|
      old_result.call(clase, metodo) anda not join_point.aplica?(clase, metodo)
    end
  end

  def or_not(join_point)
    old_result = self.method(:aplica?)
    self.send :define_singleton_method, :aplica? do
    |clase, metodo|
      old_result.call(clase, metodo) or not join_point.aplica?(clase, metodo)
    end
  end

  def aplica?(clase, metodo)
    true
  end

end
