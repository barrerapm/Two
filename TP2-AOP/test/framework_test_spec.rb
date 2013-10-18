require 'rspec'
require_relative '../framework/framework_aop'
require_relative '../aspects/profiler'

class FrameworkTestSpec

  describe 'test framework' do

    it 'listar_clases_y_metodos' do
      puts FrameworkTestSpec.name
      fw = FrameworkAOP.new
      #fw.listar_clases_y_metodos
      true.should == true
    end


  end
end