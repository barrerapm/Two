require 'rspec'
require_relative '../../framework/join_points/class_jp'

describe 'Test Clases especificas' do

  class Persona

  end

  class Animal

  end

  jp = ClassJP.new(Persona)

  it 'debe coincidir la clase' do
    jp.set_parametro_clase(Persona)
    true.should == jp.match?(Persona, nil)
    jp.set_parametro_clase(Animal)
    false.should == jp.match?(Persona, nil)
  end

  it 'NO debe coincidir la clase' do
    jp.set_parametro_clase(Animal)
    false.should == jp.match?(Persona, nil)
  end

end