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
    (not true).should == jp.aplica?(Persona, nil).empty?
    jp.set_regex(/[A-Z].*/)
    (not true).should == jp.aplica?(Persona, nil).empty?
  end

  it 'debe encontrar el Metodo en la expresion regular' do
    jp.set_regex(/de.*la/)
    (not true).should == jp.aplica?(nil,  Persona.instance_methods(false).first).empty?
    jp.set_regex(/.*cir.*/)
    (not true).should == jp.aplica?(nil,  Persona.instance_methods(false).first).empty?
  end

  it 'NO debe encontrar la Clase en la expresion regular' do
    jp.set_regex(/Person[A-Z]/)
    true.should == jp.aplica?(Persona, nil).empty?
  end

  it 'NO debe encontrar el Metodo en la expresion regular' do
    jp.set_regex(/Decir.*/)
    true.should == jp.aplica?(nil, Persona.instance_methods(false).first).empty?
  end

end