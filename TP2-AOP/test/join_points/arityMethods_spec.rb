require 'rspec'
require_relative '../../framework/join_points/join_point'
require_relative '../../framework/join_points/arity_methods'
require_relative '../../framework/join_points/method_regex'

describe 'Testeo de filtrado de metodos por aridad' do

  class Persona
    def vivir_en(direccion, numero, piso)
    end
    def definir_masa(peso, altura)
    end
    def caminar
    end
  end

  it 'Encuentra el metodo' do
   detector_aridad = Arity_methods.new((0..1))
   #detector_aridad.imprimir(Persona)
    resultado = detector_aridad.match?(Persona, /hola a todos/)

    resultado.should == true
  end

  it 'No encuentra el metodo' do
    detector_aridad = Arity_methods.new((7..10))
    #detector_aridad.imprimir(Persona)
    resultado = detector_aridad.match?(Persona, /hola a todos/)

    resultado.should == false
  end
end
