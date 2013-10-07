require 'rspec'
require_relative '../framework/parameter_name_join_point'

describe 'Test Nombre de Parametros' do

  metodo = ->(param1,param2=2) {}
  jp = ParameterNameJoinPoint.new('param1')

  it 'debe encontrar simbolos en los parametros del metodo' do
    jp.set_parametro('param1')
    (not true).should == jp.aplica?(nil, metodo).empty?
    jp.set_parametro('param2')
    (not true).should == jp.aplica?(nil, metodo).empty?
  end

  it 'NO debe encontrar ESTE simbolo en los parametros del metodo' do
    jp.set_parametro('param3')
    true.should == jp.aplica?(nil, metodo).empty?
  end

end