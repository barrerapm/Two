require 'rspec'
require_relative '../../framework/framework_aop'
require_relative '../../aspects/cache_sin_estado'
require_relative '../../aspects/cache_con_estado'
require_relative '../../framework/interceptors/interceptor_after'
require_relative '../../framework/interceptors/interceptor_before'
require_relative '../../framework/interceptors/interceptor_instead_of'
require_relative '../../framework/join_points/class_method_name'

describe 'Aspecto de cache con estado' do

  #Pasos del test
  #1- Crear una clase con un metodo con un parametro y un atributo, donde el metodo devuelva attr + param
  #2- Attr = 0; Llamar al metodo con 5 => metodo devuelve 5
  #3- Setear Attr = 8; Llamar al metodo con 5 => metodo devuelve 5 (la cache no tiene en cuenta el estado del obj)

  class Persona
    attr_accessor :anio_actual
    def nacimiento(edad)
      @anio_actual.to_int - edad.to_int
    end
  end

  it 'should prueba del funcionamiento de la cache con estado' do
    fw = FrameworkAOP.new
    aspect_cache_con_estado = CacheConEstadoAspect.new
    aspect_cache_con_estado.interceptor = InterceptorInsteadOf.new
    point_cut_simple = Class_method_name.new(:nacimiento)
    aspect_cache_con_estado.point_cut = point_cut_simple
    fw.load_aspect(aspect_cache_con_estado)

    persona = Persona.new
    persona.anio_actual = 2013
    persona.nacimiento(23).should == 1990
    persona.nacimiento(23).should == 1990
    persona.anio_actual = 2010
    persona.nacimiento(23).should == 1987
  end

end
