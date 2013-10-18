require 'rspec'
require_relative '../../framework/join_points/parameter_type'

describe 'Test Tipo de Parametros' do

  metodo = ->(param1,param2=1,param3) {}
  jp = ParameterType.new(:req)

  it 'los 2 del tipo :req' do
    p 'los 2 del tipo :req'  # aca tuve que repetir codigo si o si, por culpa de como rspec hace las cosas
    jp.tipo_de_parametro= :req
    resultado_lista = jp.matchTipoParametros(metodo)
    p resultado_lista
    true.should == (resultado_lista.size == 2)
    puts

    true.should == jp.aplica?(nil, metodo)
  end

  it 'el del tipo :opt' do
    p 'el del tipo :opt'  # aca tuve que repetir codigo si o si, por culpa de como rspec hace las cosas
    jp.tipo_de_parametro= :opt
    resultado_lista = jp.matchTipoParametros(metodo)
    p resultado_lista
    true.should == (resultado_lista.size == 1)
    true.should == jp.aplica?(nil, metodo)
  end

  it 'el del tipo :tipo_inexistente' do
    p 'el del tipo :tipo_inexistente'  # aca tuve que repetir codigo si o si, por culpa de como rspec hace las cosas
    jp.tipo_de_parametro= :tipo_inexistente
    resultado_lista = jp.matchTipoParametros(metodo)
    p resultado_lista
    true.should == (resultado_lista.size == 0)
    (not true).should == jp.aplica?(nil, metodo)
  end

end