require 'rspec'
require_relative '../../framework/join_points/join_point'
require_relative '../../framework/join_points/accessors_method_name'

describe 'Testeo de filtrado de metodos que son accessors' do

  class Persona
    attr_accessor :nombre, :edad

    def intialize
    end

    def caminar
    end
  end

  class Animal
   def saludar
   end
  end

  it 'Encuentra el método' do
    jp = AccessorsMethodName.new
    resultado = jp.match?(Persona, /hola/)

    resultado.should == true
  end

  it 'Encuentra el método' do
    jp = AccessorsMethodName.new
    resultado = jp.match?(Animal, /hola/)

    resultado.should == false
  end
end
