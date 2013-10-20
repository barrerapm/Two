require 'rspec'
require_relative '../framework/framework_aop'
require_relative '../aspects/cache_sin_estado'
require_relative '../framework/interceptors/interceptor_after'
require_relative '../framework/interceptors/interceptor_instead_of'

class FrameworkTestSpec

  describe 'test framework' do

    before(:each) do
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

    after(:each) do
      if(Object.constants.include?(:PersonaTest))
        Object.send(:remove_const, :PersonaTest)
      end
    end

    class AspectTestPersonaInterceptor < Aspect

      def exec(context)
        context.object.nombre = 'GGG'
      end

      def methods_to_intercept(clase)
        clase.instance_methods(false).keep_if do |method|
          method.to_s == 'guardar_nombre'
        end
      end

    end

    class AspectTestPersonaInterceptorInsteadOf < Aspect

      def exec(context)
        context.object.fecha_nacimiento = Date.today
      end

      def methods_to_intercept(clase)
        clase.instance_methods(false).keep_if do |method|
          method.to_s == 'guardar_fecha_nacimiento'
        end
      end

    end

    it 'load_aspect' do
      fw = FrameworkAOP.new
      aspect_person = AspectTestPersonaInterceptor.new(nil)
      aspect_person.interceptor = InterceptorAfter.new
      fw.load_aspect(aspect_person)

      persona = PersonaTest.new
      persona.guardar_nombre('G')
      persona.nombre.should == 'GGG'
    end

    it 'load_aspect instead of' do
      fw = FrameworkAOP.new
      aspect_person = AspectTestPersonaInterceptorInsteadOf.new(nil)
      aspect_person.interceptor = InterceptorInsteadOf.new
      fw.load_aspect(aspect_person)

      persona = PersonaTest.new
      persona.guardar_fecha_nacimiento(10,10,1990)
      persona.fecha_nacimiento.year == Date.today.year
      persona.fecha_nacimiento.month == Date.today.month
      persona.fecha_nacimiento.day == Date.today.day
    end

  end
end