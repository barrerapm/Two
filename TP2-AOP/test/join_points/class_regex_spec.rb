require 'rspec'
require_relative '../../framework/join_points/class_regex'

describe 'Test Expresiones Regulares en Clases' do

  class Persona
    def decir_hola
      p 'hola'
    end
  end

  jp = ClassRegex.new(/.sona/)

  it 'debe encontrar la Clase en la expresion regular' do
    jp.set_regex(/.*sona/)
    true.should == jp.match?(Persona, nil)
    jp.set_regex(/[A-Z].*/)
    true.should == jp.match?(Persona, nil)
  end

  it 'NO debe encontrar la Clase en la expresion regular' do
    jp.set_regex(/Person[A-Z]/)
    false.should == jp.match?(Persona, nil)
  end

end