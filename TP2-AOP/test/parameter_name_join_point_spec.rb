require 'rspec'
require_relative '../framework/parameter_name_join_point'

describe 'Test Parameter Name' do

  it 'debe encontrar simbolos en los parametros del metodo' do
    metodo = ->(param1,param2=2) {}
    jp = ParameterNameJoinPoint.new(metodo)
    false.should == jp.tiene_este_parametro?('param1').empty?
    false.should == jp.tiene_este_parametro?('param2').empty?
  end

  it 'NO debe encontrar ESTE simbolo en los parametros del metodo' do
    metodo = ->(param1,param2=2) {}
    jp = ParameterNameJoinPoint.new(metodo)
    true.should == jp.tiene_este_parametro?('param3').empty?
  end

end