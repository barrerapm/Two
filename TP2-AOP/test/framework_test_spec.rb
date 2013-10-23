require 'rspec'
require_relative '../framework/framework_aop'
require_relative '../aspects/cache_sin_estado'
require_relative '../framework/interceptors/interceptor_after'
require_relative '../framework/interceptors/interceptor_instead_of'
require_relative '../framework/join_points/method_regex'

class FrameworkTestSpec

  describe 'test framework' do

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

    class AspectTestPersonaInterceptorInsteadOf < Aspect

      def exec(context)
        context.object.fecha_nacimiento = Date.today
      end

    end

    class AspectGuardaObjeto < Aspect

      attr_accessor :object_saved

      def exec(context)
        @object_saved = context.object
      end

    end

    class AspectGuardaUltimaClase < Aspect

      attr_accessor :last_call_class

      def exec(context)
        @last_call_class = context.object.class.to_s
      end

    end

    class AspectFlagTrueOnCall < Aspect

      attr_accessor :boolean_value

      def exec(context)
        @boolean_value = true
      end

    end

    it 'se aplica el aspecto solamente al nombre' do
      fw = FrameworkAOP.instance
      aspect_person = AspectTestPersonaInterceptor.new(nil)
      aspect_person.point_cut = MethodRegex.new(/guardar_nombre/)
      aspect_person.interceptor = InterceptorAfter.new
      fw.load_aspect(aspect_person)

      persona = PersonaTest.new
      persona.guardar_nombre('G')
      persona.nombre.should == 'GGG'
      persona.guardar_fecha_nacimiento(10,10,1990)
      persona.fecha_nacimiento.year.should == 1990
      persona.fecha_nacimiento.month.should == 10
      persona.fecha_nacimiento.day.should == 10
    end

    it 'se aplica el aspecto solamente a la fecha' do
      fw = FrameworkAOP.instance
      aspect_person = AspectTestPersonaInterceptorInsteadOf.new(nil)
      aspect_person.interceptor = InterceptorInsteadOf.new
      aspect_person.point_cut = MethodRegex.new(/guardar_fecha_nacimiento/)
      fw.load_aspect(aspect_person)

      persona = PersonaTest.new
      persona.guardar_nombre('G')
      persona.nombre.should == 'G'
      persona.guardar_fecha_nacimiento(10,10,1990)
      persona.fecha_nacimiento.year.should == Date.today.year
      persona.fecha_nacimiento.month.should == Date.today.month
      persona.fecha_nacimiento.day.should == Date.today.day
    end

    it 'se intercepta y se aspectea el metodo a una clase creada dinamicamente' do
      fw = FrameworkAOP.instance
      aspect_test = AspectGuardaObjeto.new(MethodRegex.new(/imprimir_algo/))
      aspect_test.interceptor = InterceptorInsteadOf.new
      fw.load_aspect(aspect_test)

      class NuevaClasePrueba
        def imprimir_algo
          puts 'imprimir_algo'
        end
      end

      aspect_test.object_saved = 'objeto string guardado'
      test_imprimir_algo = NuevaClasePrueba.new
      test_imprimir_algo.imprimir_algo
      aspect_test.object_saved.should == test_imprimir_algo
    end

    it 'se intercepta y NO se aspectea el metodo a una clase creada dinamicamente porque no cumple' do
      fw = FrameworkAOP.instance
      aspect_test = AspectGuardaObjeto.new(MethodRegex.new(/esto_no_matchea_con_nada/))
      aspect_test.interceptor = InterceptorInsteadOf.new
      fw.load_aspect(aspect_test)

      class NuevaClasePrueba2
        def un_metodo
          puts 'test'
        end
      end

      aspect_test.object_saved = 'objeto string guardado'
      test_obj = NuevaClasePrueba2.new
      test_obj.un_metodo
      aspect_test.object_saved.should == 'objeto string guardado'
    end

    it 'se interceptan dos metodos de una clase creada dinamicamente con un aspecto para cada metodo' do
      fw = FrameworkAOP.instance
      aspect_test_bool = AspectFlagTrueOnCall.new(MethodRegex.new(/test_boolean_method/))
      aspect_test_bool.interceptor = InterceptorInsteadOf.new
      aspect_test_classname = AspectGuardaUltimaClase.new(MethodRegex.new(/test_classname_method/))
      aspect_test_classname.interceptor = InterceptorInsteadOf.new
      #Cargo los aspectos en el framework
      fw.load_aspect(aspect_test_bool)
      fw.load_aspect(aspect_test_classname)

      class NuevaClasePrueba3
        def test_boolean_method
          puts 'imprimir_algo'
        end
        def test_classname_method
          puts 'imprimir_algo'
        end
      end

      #Valores iniciales de los aspectos
      aspect_test_bool.boolean_value = false;
      aspect_test_classname.last_call_class = ''

      test_object = NuevaClasePrueba3.new
      #llamada al primer metodo interceptado
      test_object.test_boolean_method
      aspect_test_bool.boolean_value.should == true
      aspect_test_classname.last_call_class.should == ''
      #llamada al segundo metodo interceptado
      test_object.test_classname_method
      aspect_test_bool.boolean_value.should == true
      aspect_test_classname.last_call_class.should == test_object.class.to_s
    end

  end
end