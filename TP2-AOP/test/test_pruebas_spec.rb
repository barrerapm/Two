require 'rspec'

describe 'Pruebas de Reflection' do

  class Persona

    attr_accessor :map_parameters

    def initialize
      @map_parameters = {}
    end

    def put_map(symbol)
      method(symbol).parameters.each do |param|
        @map_parameters[param[1]] = "G"
        Symbol
      end
    end

    def saludar(alguien)
      puts 'Hola ' + alguien
      self.put_map(:saludar)
    end

  end

  it 'should do something' do
    persona = Persona.new
    persona.saludar("G")
    persona.map_parameters[:alguien].should == "G"
  end

end