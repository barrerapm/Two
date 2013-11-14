require 'rspec'
require_relative '../../framework/framework_aop'
require_relative '../../aspects/cache_sin_estado'
require_relative '../../framework/interceptors/interceptor_after'
require_relative '../../framework/interceptors/interceptor_before'
require_relative '../../framework/interceptors/interceptor_instead_of'
require_relative '../../framework/join_points/class_method_name'

describe 'Aspecto de cache sin estado' do

  class Persona
    attr_accessor :altura

    def initialize(alt)
      @altura = alt
    end

    def es_mas_alto?(alt)
      @altura < alt
    end
  end

  it 'should prueba del funcionamiento de la cache sin estado' do
    fw = FrameworkAOP.instance
    aspect_cache_sin_estado = CacheSinEstadoAspect.new
    aspect_cache_sin_estado.interceptor = InterceptorInsteadOf.new
    point_cut_simple = Class_method_name.new(:es_mas_alto?)
    aspect_cache_sin_estado.point_cut = point_cut_simple
    fw.load_aspect(aspect_cache_sin_estado)

    persona = Persona.new(1.7)
    resultado = persona.es_mas_alto?(1.8)
    resultado.should == true
    resultado = persona.es_mas_alto?(1.6)
    resultado.should == false
    resultado = persona.es_mas_alto?(1.8)
    resultado.should == true
  end

end
