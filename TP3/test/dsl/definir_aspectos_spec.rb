require 'rspec'
require_relative '../../dsl/aspects'


class Prueba1
  def metodo_prueba_1; end
end

class Prueba2
  def metodo_prueba; end
end

class Prueba3
  def metodo_prueba
    raise 'una excepcion'
  end
end

class Prueba4
  def metodo_prueba; end
end

class PruebaMatchVariosJP
  def metodo_1(a);end
  def metodo_2(a, b);end
  def metodo_3(a, b, c);end
  def function(a, b, c, d);end
end


class Test

  class << self
    attr_accessor :last_status, :first_status
  end

end

describe 'Creacion de aspectos por DSL' do

  before(:each) do
    Test.last_status = nil
    Test.first_status = nil
  end


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

    Prueba1.new.metodo_prueba_1.should == 'hello'
  end


  it 'crear aspecto before y after' do
    module Aspects
      aspect do

        after do |context|
          Test.last_status = 'complete'
        end

        before do |context|
          Test.first_status = 'complete'
        end

        cuando do
          expresion_regular clase es /Prueba2/
        end

      end
    end
    prueba_2 = Prueba2.new
    prueba_2.metodo_prueba
    Test.last_status.should == 'complete'
    Test.first_status.should == 'complete'
  end


  it 'crear aspecto on exception' do

    module Aspects

      aspect do

        on_exception do |context|
          Test.last_status = 'complete_exception'
        end

        cuando do
          expresion_regular clase es /Prueba3/
        end

      end

    end
    expect { Prueba3.new.metodo_prueba }.to raise_error(Exception)
    Test.last_status.should == 'complete_exception'
  end


  it 'crear aspecto con estado' do

    module Aspects

      aspect do

        instead_of do |context|
          @counter = @counter == nil ? 1 : @counter + 1
          Test.last_status = @counter
        end

        cuando do
          expresion_regular clase es /Prueba4/
        end

      end

    end
    prueba = Prueba4.new
    prueba.metodo_prueba
    prueba.metodo_prueba
    prueba.metodo_prueba
    Test.last_status.should == 3
  end


  it 'prueba varias condiciones' do
    module Aspects

      aspect do

        instead_of do |context|
          'complete'
        end

        cuando do
          #(expresion_regular clase es /MatchVarios/).and(expresion_regular metodo es /metodo/)
          aridad metodo es 3..5
        end

      end

    end
    #prueba = PruebaMatchVariosJP.new
    #(prueba.metodo_1(0) == 'complete').should == false
    #(prueba.metodo_2(0,1) == 'complete').should == false
    #prueba.metodo_3(0,1,2).should == 'complete'
    #(prueba.function(0,1,2,3) == 'complete').should == false

  end


end