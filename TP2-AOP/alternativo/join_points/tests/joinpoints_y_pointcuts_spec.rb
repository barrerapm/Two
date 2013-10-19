require 'rspec'
require_relative '../../framework'
require_relative '../class_name'
require_relative '../pointcut'

describe 'Join points' do

  # ACA SE TESTEA QUE CADA OPERACION ENTRE JOIN POINTS EFECTIVAMENTE SEA DEL TIPO POINT CUT
  it 'jp1 & jp2 => Pointcut' do
    fwk = Framework.new
    jp1 = ClassName.new(fwk.array_clases, /no_importa_este_texto/)
    jp2 = ClassName.new(fwk.array_clases, /no_importa_este_texto/)
    (jp1 & jp2).class.should == Pointcut
  end

  it 'jp1 | jp2 => Pointcut' do
    fwk = Framework.new
    jp1 = ClassName.new(fwk.array_clases, /no_importa_este_texto/)
    jp2 = ClassName.new(fwk.array_clases, /no_importa_este_texto/)
    (jp1 | jp2).class.should == Pointcut
  end

  it '~jp1 => Pointcut' do
    fwk = Framework.new
    jp1 = ClassName.new(fwk.array_clases, /no_importa_este_texto/)
    (~jp1).class.should == Pointcut
  end

  # ACA SE TESTEA QUE CADA OPERACION ENTRE POINT CUTS EFECTIVAMENTE SEA DEL TIPO POINT CUT
  it 'pc1 & pc2 => Pointcut' do
    fwk = Framework.new
    jp1 = ClassName.new(fwk.array_clases, /no_importa_este_texto/)
    jp2 = ClassName.new(fwk.array_clases, /no_importa_este_texto/)
    pc1 = jp1 & jp2
    pc2 = jp2 & jp1
    (pc1 & pc2).class.should == Pointcut
  end

  it 'pc1 | pc2 => Pointcut' do
    fwk = Framework.new
    jp1 = ClassName.new(fwk.array_clases, /no_importa_este_texto/)
    jp2 = ClassName.new(fwk.array_clases, /no_importa_este_texto/)
    pc1 = jp1 & jp2
    pc2 = jp2 & jp1
    (pc1 | pc2).class.should == Pointcut
  end

  it '~pc1 => Pointcut' do
    fwk = Framework.new
    jp1 = ClassName.new(fwk.array_clases, /no_importa_este_texto/)
    jp2 = ClassName.new(fwk.array_clases, /no_importa_este_texto/)
    pc1 = jp1 & jp2
    (~pc1).class.should == Pointcut
  end

end
