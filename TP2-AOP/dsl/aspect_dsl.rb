require_relative '../dsl/point_cut_dsl'
require_relative '../dsl/interceptor_dsl'
require_relative '../framework/interceptors/interceptor_instead_of'
require_relative '../framework/custom_aspect'

class AspectDSL

  attr :before_block, :after_block, :instead_of_block, :on_exception_block
  attr_accessor :interceptor, :aspect, :point_cut

  def initialize
    @interceptor = InterceptorDSL.new
    @interceptor.aspect_dsl = self
  end

  def before(&block)
    @before_block = block
  end

  def instead_of(&block)
    @instead_of_block = block
    @interceptor = InterceptorInsteadOf.new
  end

  def after(&block)
    @after_block = block
  end

  def on_exception(&block)
    @on_exception_block = block
  end

  def cuando(&block)
    pointcut_dsl = PointCutDSL.new
    pointcut_dsl.instance_eval &block
    @point_cut = pointcut_dsl.build_point_cut
  end

  def build_aspect
    aspect = CustomAspect.new(point_cut)
    aspect.interceptor = @interceptor
    aspect.define_exec(&instead_of_block) #instead of reemplaza toda la ejecucion
    aspect
  end

end