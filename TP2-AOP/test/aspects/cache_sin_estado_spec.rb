require 'rspec'

describe 'Aspecto de cache sin estado' do

  #Pasos del test
  #1- Crear una clase con un metodo con un parametro y un atributo, donde el metodo devuelva attr + param
  #2- Attr = 0; Llamar al metodo con 5 => metodo devuelve 5
  #3- Setear Attr = 8; Llamar al metodo con 5 => metodo devuelve 5 (la cache no tiene en cuenta el estado del obj)

  it 'should prueba del funcionamiento de la cache' do
    true.should == false
  end

end