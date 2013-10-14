require 'rspec'
require_relative '../framework/method_regex_join_point'

describe 'Test Expresiones Regulares en Metodos' do

  class Persona
    def decir_hola
      p 'hola'
    end
  end

  jp = MethodRegexJoinPoint.new(/de,*la/)

  it 'debe encontrar el Metodo en la expresion regular' do
    jp.set_regex(/de.*la/)
    true.should == jp.aplica?(nil,  Persona.instance_methods(false).first)
    jp.set_regex(/.*cir.*/)
    true.should == jp.aplica?(nil,  Persona.instance_methods(false).first)
  end

  it 'NO debe encontrar el Metodo en la expresion regular' do
    jp.set_regex(/Decir.*/)
    false.should == jp.aplica?(nil, Persona.instance_methods(false).first)
  end

end