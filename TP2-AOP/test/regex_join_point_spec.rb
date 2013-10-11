require 'rspec'
require_relative '../framework/regex_join_point'

describe 'Test Expresiones Regulares' do

  class Persona
    def decir_hola
      p 'hola'
    end
  end

  jp = RegexJoinPoint.new(/.sona/)

  it 'debe encontrar la Clase en la expresion regular' do
    jp.set_regex(/.*sona/)
    true.should == jp.aplica?(Persona, nil)
    jp.set_regex(/[A-Z].*/)
    true.should == jp.aplica?(Persona, nil)
  end

  it 'debe encontrar el Metodo en la expresion regular' do
    jp.set_regex(/de.*la/)
    true.should == jp.aplica?(nil,  Persona.instance_methods(false).first)
    jp.set_regex(/.*cir.*/)
    true.should == jp.aplica?(nil,  Persona.instance_methods(false).first)
  end

  it 'NO debe encontrar la Clase en la expresion regular' do
    jp.set_regex(/Person[A-Z]/)
    false.should == jp.aplica?(Persona, nil)
  end

  it 'NO debe encontrar el Metodo en la expresion regular' do
    jp.set_regex(/Decir.*/)
    false.should == jp.aplica?(nil, Persona.instance_methods(false).first)
  end

end