require_relative '../dsl/aspect_dsl'
require_relative '../framework/framework_aop'

module Aspects

  def self.aspect(&bloque)
    framework_aop = FrameworkAOP.instance
    aspect_dsl = AspectDSL.new
    aspect_dsl.instance_eval &bloque
    framework_aop.load_aspect(aspect_dsl.build_aspect)
  end

end