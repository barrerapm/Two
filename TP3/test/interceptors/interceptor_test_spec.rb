require 'rspec'
require_relative '../../framework/context'
require_relative '../../aspects/cache_sin_estado'
require_relative '../../framework/interceptors/interceptor_before'
require_relative '../../framework/interceptors/interceptor_after'
require_relative '../../framework/interceptors/interceptor_instead_of'
require_relative '../../framework/interceptors/interceptor_on_error'

describe 'Funcionamiento de Interceptor (redefine los metodos de la clase)' do

  before(:each) do
    if(Object.constants.include?(:PersonaTest))
      Object.send(:remove_const, :PersonaTest)
    end
    class PersonaTest

      attr_accessor :nombre, :fecha_nacimiento

      def guardar_nombre(nombre)
        if(nombre == nil)
          raise 'Excepcion por nombre nil'
        end
        @nombre = nombre
      end

      def guardar_fecha_nacimiento(dia, mes, anio)
        @fecha_nacimiento = Date.new(anio, mes, dia)
      end

    end
  end

  class AspectTestPersonaInterceptor < Aspect

    def exec(context)
      context.object.nombre = 'GGG'
    end

  end

  class AspectTestGuardarContexto < Aspect

    attr_accessor :context

    def exec(context)
      @context = context
    end

  end

  it 'InterceptorBefore' do
    persona = PersonaTest.new
    interceptor = InterceptorBefore.new
    interceptor.intercept(persona, :guardar_nombre, AspectTestPersonaInterceptor.new(nil), 'G')
    persona.nombre.should == 'G'
  end

  it 'InterceptorAfter' do
    persona = PersonaTest.new
    interceptor = InterceptorAfter.new
    interceptor.intercept(persona, :guardar_nombre, AspectTestPersonaInterceptor.new(nil), 'G')
    persona.nombre.should == 'GGG'
  end

  it 'InterceptorInsteadOf' do
    persona = PersonaTest.new
    interceptor = InterceptorInsteadOf.new
    interceptor.intercept(persona, :guardar_nombre, AspectTestPersonaInterceptor.new(nil), 'G')
    persona.nombre.should == 'GGG'
  end

  it 'InterceptorOnError' do
    persona = PersonaTest.new
    interceptor = InterceptorOnError.new
    expect { interceptor.intercept(persona, :guardar_nombre, AspectTestPersonaInterceptor.new(nil), nil) }.to raise_error
    persona.nombre.should == 'GGG'
  end

  it 'obtener el contexto' do
    persona = PersonaTest.new
    interceptor = InterceptorInsteadOf.new
    aspect = AspectTestGuardarContexto.new(nil)
    interceptor.intercept(persona, :guardar_nombre, aspect, 'G')
    aspect.context.object.should == persona
    aspect.context.method_origin.should == :guardar_nombre
    aspect.context.parameter_values.should == {:nombre => 'G'}
  end


end