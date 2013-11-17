require_relative '../dsl/point_cut_dsl'
require_relative '../dsl/interceptor_dsl'
require_relative '../framework/interceptors/interceptor_instead_of'
require_relative '../framework/interceptors/interceptor_after'
require_relative '../framework/interceptors/interceptor_before'
require_relative '../framework/interceptors/interceptor_on_error'
require_relative '../framework/custom_aspect'

class AspectDSL

  attr_accessor :exec_block, :interceptor, :aspect, :point_cut, :before_block, :after_block, :on_exception_block

  def initialize
    @interceptor = InterceptorDSL.new
    initialize_empty_block
  end

  def initialize_empty_block
    self.instance_eval do
      before do |context|

      end
      after do |context|

      end
      on_exception do |context|

      end
    end
  end

  def before(&block)
    @exec_block = block
    @before_block = block
  end

  def instead_of(&block)
    @exec_block = block
    @interceptor = InterceptorInsteadOf.new
  end

  def after(&block)
    @exec_block = block
    @after_block = block
  end

  def on_exception(&block)
    @exec_block = block
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
    aspect.define_exec(&@exec_block)
    aspect.before_block(&@before_block)
    aspect.after_block(&@after_block)
    aspect.on_exception_block(&@on_exception_block)
    aspect
  end

end