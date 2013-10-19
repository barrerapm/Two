require 'rspec'
require_relative '../../framework'
require_relative '../joinpoint'
require_relative '../class_name'

describe 'Join points' do

  # ACA SE TESTEA QUE CADA OPERACION ENTRE JOIN POINTS EFECTIVAMENTE SEA DEL TIPO POINT CUT
  it 'jp1 & jp2 => pc' do
    fwk = Framework.new
    jp1 = ClassName.new(fwk.array_clases, /no_importa_este_texto/)
    jp2 = ClassName.new(fwk.array_clases, /no_importa_este_texto/)
    (jp1 & jp2).class.should == Pointcut
  end

  it 'jp1 | jp2 => pc' do
    fwk = Framework.new
    jp1 = ClassName.new(fwk.array_clases, /no_importa_este_texto/)
    jp2 = ClassName.new(fwk.array_clases, /no_importa_este_texto/)
    (jp1 | jp2).class.should == Pointcut
  end

  it '~jp1 => pc' do
    fwk = Framework.new
    jp1 = ClassName.new(fwk.array_clases, /no_importa_este_texto/)
    (~jp1).class.should == Pointcut
  end

  #

end