require 'rspec'
require_relative '../framework/class_join_point'

describe 'Test Clases especificas' do

  class Persona

  end

  class Animal

  end

  jp = ClassJoinPoint.new(Persona)

  it 'debe coincidir la clase' do
    jp.set_parametro_clase(Persona)
    true.should == jp.aplica?(Persona, nil)
    jp.set_parametro_clase(Animal)
    false.should == jp.aplica?(Persona, nil)
  end

  it 'NO debe coincidir la clase' do
    jp.set_parametro_clase(Animal)
    false.should == jp.aplica?(Persona, nil)
  end

end