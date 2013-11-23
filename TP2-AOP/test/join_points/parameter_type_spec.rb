require 'rspec'
require_relative '../../framework/join_points/parameter_type'

describe 'Test Tipo de Parametros' do

  class Prueba
    def metodo1(param1, param2=1, param3)
    end
  end

  it 'los 2 del tipo :req' do
    jp = ParameterType.new(:req)
    metodo = Prueba.instance_method(:metodo1)
    resultado_lista = jp.matchTipoParametros(metodo)
    2.should == resultado_lista.size
    true.should == jp.match?(Prueba, Prueba.instance_method(:metodo1))
  end

  it 'el del tipo :opt' do
    jp = ParameterType.new(:opt)
    metodo = Prueba.instance_method(:metodo1)
    resultado_lista = jp.matchTipoParametros(metodo)
    1.should == resultado_lista.size
    true.should == jp.match?(Prueba, metodo)
  end

  it 'el del tipo :tipo_inexistente' do
    p 'el del tipo :tipo_inexistente'  # aca tuve que repetir codigo si o si, por culpa de como rspec hace las cosas
    jp = ParameterType.new(:tipo_inexistente)
    metodo = Prueba.instance_method(:metodo1)
    resultado_lista = jp.matchTipoParametros(metodo)
    0.should == resultado_lista.size
    (not true).should == jp.match?(Prueba, metodo)
  end

end