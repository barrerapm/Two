require 'rspec'
require_relative '../framework/class_hierarchy_join_point'

describe 'Test Jerarquia de Clases' do

  class Animal
  end

  class Felino < Animal
  end

  class Mamifero < Animal
  end

  class Perro < Mamifero
  end

  jp = ClassHierarchyJoinPoint.new('Perro')

  it 'debe pertenecer a la jerarquia de la clase padre' do
    jp.set_parametro_clase_padre('Animal')
    (not true).should == jp.aplica?(Mamifero, nil).empty?
    (not true).should == jp.aplica?(Felino, nil).empty?
    (not true).should == jp.aplica?(Perro, nil).empty?
  end

  it 'NO debe pertenecer a la jerarquia de la clase padre' do
    jp.set_parametro_clase('Felino')
    true.should == jp.aplica?(Perro, nil).empty?
  end

end