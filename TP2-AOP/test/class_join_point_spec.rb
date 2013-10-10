require 'rspec'
require_relative '../framework/class_join_point'

describe 'Test Clases especificas' do

  class Persona

  end

  class Objeto

  end

  jp = ClassJoinPoint.new('Persona')

  it 'debe coincidir la clase' do
    jp.set_parametro_clase('Persona')
    (not true).should == jp.aplica?(Persona, nil).empty?
    jp.set_parametro_clase('Objeto')
    (not true).should == jp.aplica?(Objeto, nil).empty?
  end

  it 'NO debe coincidir la clase' do
    jp.set_parametro_clase('Objeto')
    true.should == jp.aplica?(Persona, nil).empty?
  end

end