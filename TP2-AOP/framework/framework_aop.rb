class FrameworkAOP

  attr_accessor :array_clases

  # en caso de querer instanciarlo con otra cosa que no sea ObjectSpace, pasarlo como array (no como enum) al Framework
  def initialize(array_clases=ObjectSpace.each_object(Class).to_a)
    @array_clases = array_clases
  end

  def load_aspect(aspect)
    @array_clases.each do |clazz|
      methods = aspect.methods_to_intercept(clazz)
      methods.each do |method|
        clazz.send :alias_method, "__#{method}__", method
        clazz.send :define_method, method do |*args|
          aspect.interceptor.intercept(self, "__#{method}__", aspect, *args)
        end
      end
    end
  end

end