require 'singleton'

class FrameworkAOP
  include Singleton

  attr_accessor :array_clases, :aspects, :instance, :dynamic_classes

  # en caso de querer instanciarlo con otra cosa que no sea ObjectSpace, pasarlo como array (no como enum) al Framework
  def initialize(array_clases=ObjectSpace.each_object(Class).to_a)
    @array_clases = array_clases
    @dynamic_classes = []
    @aspects = []
    define_listener_dynamic_methods
  end

  def load_aspect(aspect)
    @aspects << aspect
    @array_clases.each do |clazz|
      load_aspect_to_class(aspect, clazz)
    end
  end

  def load_aspect_to_class(aspect, clazz)
    methods = aspect.methods_to_intercept(clazz)
    methods.each do |method|
      load_aspect_to_class_method(aspect, clazz, method)
    end
  end

  def load_aspect_to_class_method(aspect, clazz, method)
    clazz.send :alias_method, "__#{method}__", method
    clazz.send :define_method, method do |*args|
      aspect.interceptor.intercept(self, "__#{method}__", aspect, *args)
    end
  end

  def define_listener_dynamic_methods
    Object.class_eval do
      def self.inherited(subclass)
        fw = FrameworkAOP.instance
        fw.dynamic_classes << subclass
      end
    end
    self.on_listener
  end

  def on_listener
    Object.class_eval do
      def self.method_added(method)
        fw = FrameworkAOP.instance
        if(not fw.dynamic_classes.include?(self))
          return
        end
        fw.off_listener; #Se deja de escuchar que metodo se agrego, para que el fw agregue metodos a las clases aspecteadas sin interceptarse
        fw.aspects.each do |aspect|
          methods = aspect.methods_to_intercept(self)
          if(methods.include?(method))
            fw.load_aspect_to_class_method(aspect, self, method)
          end
        end
        fw.on_listener
      end
    end
  end

  def off_listener
    Object.class_eval do
      def self.method_added(method_name)
      end
    end
  end


end