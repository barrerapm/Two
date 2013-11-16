require 'rspec'
require_relative '../../dsl/aspects'


class Prueba1

  def metodo_prueba_1

  end

end

describe 'Creacion de aspectos por DSL' do

  it 'crear aspecto instead of' do

    module Aspects

      aspect do

        instead_of do |context|
          'hello'
        end

        cuando do
          expresion_regular metodo es /metodo_prueba_1/
        end

      end

    end

    prueba_1 = Prueba1.new
    prueba_1.metodo_prueba_1.should == 'hello'

  end


end