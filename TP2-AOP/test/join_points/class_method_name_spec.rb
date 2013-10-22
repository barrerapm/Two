require 'rspec'
require_relative '../../framework/join_points/class_method_name'

describe 'Test de Join Point de detección de métodos particualres de uan clase' do

  class Persona
    def calcularEdad
    end

    def caminar
    end
  end

  it 'Encuentra el método' do
    jp = Class_method_name.new

    resultado = jp.match?(Persona, :caminar)
    resultado.should == true
  end

  it 'No encuentra el método' do
    jp2 = Class_method_name.new

    resultado2 = jp2.match?(Persona, :correr)
    resultado2.should == false
  end

end
