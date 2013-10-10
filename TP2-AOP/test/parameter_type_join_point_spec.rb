require 'rspec'
require_relative '../framework/parameter_type_join_point'

describe 'Test Tipo de Parametros' do

  metodo = ->(param1,param2=1,param3) {}
  jp = ParameterTypeJoinPoint.new(:req)

  it 'los 2 del tipo :req' do
    p 'los 2 del tipo :req'  # aca tuve que repetir codigo si o si, por culpa de como rspec hace las cosas
    jp.set_tipo_de_parametro(:req)
    resultado_lista = jp.aplica?(nil, metodo)
    p resultado_lista
    true.should == (resultado_lista.size == 2)
    puts
  end

  it 'el del tipo :opt' do
    p 'el del tipo :opt'  # aca tuve que repetir codigo si o si, por culpa de como rspec hace las cosas
    jp.set_tipo_de_parametro(:opt)
    resultado_lista = jp.aplica?(nil, metodo)
    p resultado_lista
    true.should == (resultado_lista.size == 1)
  end

end