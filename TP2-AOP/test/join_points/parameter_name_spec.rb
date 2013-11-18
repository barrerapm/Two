require 'rspec'
require_relative '../../framework/join_points/parameter_name'

describe 'Test Nombre de Parametros' do

  class Persona
    def metodo_de_persona(param1, param2=2)
    end
  end

  metodo = :metodo_de_persona
  jp = ParameterName.new(:param1)

  it 'debe encontrar simbolos en los parametros del metodo' do
    jp.nombre_de_parametro= :param1
    true.should == jp.match?(Persona, metodo)
    jp.nombre_de_parametro= :param2
    true.should == jp.match?(Persona, metodo)
  end

  it 'NO debe encontrar ESTE simbolo en los parametros del metodo' do
    jp.nombre_de_parametro= :param3
    (not true).should == jp.match?(Persona, metodo)
  end

  it 'NO debe encontrar ESTE simbolo en los parametros del metodo' do
    jp1 = ParameterName.new(:param1)
    jp2 = ParameterName.new(:param1)
    true.should == (jp1 & jp2).match?(Persona, metodo)
  end


end
