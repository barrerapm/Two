class Aspect

  attr_accessor :point_cut, :interceptor

  def initialize(point_cut)
    @point_cut = point_cut
  end

  def exec(context)
    raise 'Aspecto no implementado: no se definio el metodo exec(Context c)'
  end

  def methods_to_intercept(clase)
    clase.instance_methods(false).keep_if do |metodo|
      @point_cut.match?(clase, metodo)
    end
  end

end