require 'rspec'
require_relative '../../framework/join_points/class_hierarchy'

describe 'Test Jerarquia de Clases' do

  class Animal
  end

  class Felino < Animal
  end

  class Mamifero < Animal
  end

  class Perro < Mamifero
  end

  jp = ClassHierarchy.new(Animal)

  it 'debe pertenecer a la jerarquia de la clase padre' do
    jp.set_parametro_clase_padre(Animal)
    true.should == jp.aplica?(Mamifero, nil)
    true.should == jp.aplica?(Felino, nil)
    true.should == jp.aplica?(Perro, nil)
  end

  it 'NO debe pertenecer a la jerarquia de la clase padre' do
    jp.set_parametro_clase_padre(Felino)
    false.should == jp.aplica?(Perro, nil)
  end

end