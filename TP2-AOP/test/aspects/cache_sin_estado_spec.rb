require 'rspec'
require_relative '../../framework/framework_aop'
require_relative '../../aspects/cache_sin_estado'
require_relative '../../framework/interceptors/interceptor_after'
require_relative '../../framework/interceptors/interceptor_before'
require_relative '../../framework/interceptors/interceptor_instead_of'

describe 'Aspecto de cache sin estado' do

  class Persona
    attr_accessor :vitalidad
    def initialize(vida)
      @vitalidad = vida
    end

    def caminar(km)
      @vitalidad += km
      return @vitalidad
    end
  end

  it 'should prueba del funcionamiento de la cache sin estado' do
    fw = FrameworkAOP.new
    aspect_cache_con_estado = CacheSinEstadoAspect.new
    aspect_cache_con_estado.interceptor = InterceptorInsteadOf.new
    fw.load_aspect(aspect_cache_con_estado)

    persona = Persona.new(100)
    persona.caminar(10)
    persona.vitalidad.should == 110
    persona.caminar(50)
    persona.vitalidad.should == 160
    persona.caminar(10)
    persona.vitalidad.should == 160    #no incremetna dado que en Cache sin estado no se accede al estado del objeto
  end

end
