require 'rspec'
require_relative '../framework/class_regex_join_point'

describe 'Test Expresiones Regulares en Clases' do

  class Persona
    def decir_hola
      p 'hola'
    end
  end

  jp = ClassRegexJoinPoint.new(/.sona/)

  it 'debe encontrar la Clase en la expresion regular' do
    jp.set_regex(/.*sona/)
    true.should == jp.aplica?(Persona, nil)
    jp.set_regex(/[A-Z].*/)
    true.should == jp.aplica?(Persona, nil)
  end

  it 'NO debe encontrar la Clase en la expresion regular' do
    jp.set_regex(/Person[A-Z]/)
    false.should == jp.aplica?(Persona, nil)
  end

end