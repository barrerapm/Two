require 'rspec'
require 'set'
require_relative '../../framework'
require_relative '../class_name'
require_relative '../pointcut'

describe 'Join points' do

  fwk = Framework.new
  jp1 = ClassName.new(fwk.array_clases, /no_importa_este_texto/)
  jp2 = ClassName.new(fwk.array_clases, /no_importa_este_texto/)

  # CADA OPERACION ENTRE JOIN POINTS EFECTIVAMENTE SEA DEL TIPO POINT CUT
  it 'jp1 & jp2 => Pointcut' do
    (jp1 & jp2).class.should == Pointcut
  end

  it 'jp1 | jp2 => Pointcut' do
    (jp1 | jp2).class.should == Pointcut
  end

  it '~jp1 => Pointcut' do
    (~jp1).class.should == Pointcut
  end


  # CADA OPERACION ENTRE POINT CUTS EFECTIVAMENTE SEA DEL TIPO POINT CUT
  it 'pc1 & pc2 => Pointcut' do
    pc1 = jp1 & jp2
    pc2 = jp2 & jp1
    (pc1 & pc2).class.should == Pointcut
  end

  it 'pc1 | pc2 => Pointcut' do
    pc1 = jp1 & jp2
    pc2 = jp2 & jp1
    (pc1 | pc2).class.should == Pointcut
  end

  it '~pc1 => Pointcut' do
    pc1 = jp1 & jp2
    (~pc1).class.should == Pointcut
  end


  # TESTS VARIOS
  # TODO: test sin terminar
  it 'doble negacion de un Pointcut' do
    pc1 = ClassName.new(fwk.array_clases, /hola/)
    pc2 = ~~pc1
    p pc2
  end


  # BONUS: NO TERMINADO
  it 'Operaciones entre Pointcuts y luego reconstruir lo que quedo "dentro"' do
    puts 'Operaciones entre Pointcuts y luego reconstruir lo que quedo "dentro"'
    jp3 = ClassName.new(fwk.array_clases, /no_importa_este_texto/)
    pc1 = jp1 & jp2
    pc2 = pc1 | jp3
    pc3 = ~pc2
    p pc3.to_string
  end


  # COMPARACIONES DE RESULTADOS DE OPERACIONES ENTRE Joinpoints y Pointcuts
  # PARTE 1: RESULTADOS SOLO SOBRE NOMBRES DE CLASES
  it 'debe obtener solo la clase A2' do
    class A1; end
    class A2; end
    class B; end
    array_clases = [A1,A2,B]
    jp1 = ClassName.new(array_clases, /A/)
    jp2 = ClassName.new(array_clases, /2/)
    pc1 = jp1 & jp2
    pc1.match.first.should == A2
  end

  it 'NINGUNA clase que contenga una A, y TODAS las que contengan un 2' do
    class A1; end
    class A2; end
    class B; end
    class B2; end
    class C1; end
    class C2; end
    array_clases = [A1,A2,B,B2,C1,C2]
    jp1 = ClassName.new(array_clases, /A/)
    jp2 = ClassName.new(array_clases, /2/)
    pc1 = (~jp1) & jp2
    pc1.match.should == [B2,C2].to_set
  end

  it 'NINGUNA clase que contenga 2' do
    class A1; end
    class A2; end
    class B; end
    class B2; end
    class C1; end
    class C2; end
    array_clases = [A1,A2,B,B2,C1,C2]
    jp = ClassName.new(array_clases, /2/)
    pc = ~jp
    pc.match.should == [A1,B,C1].to_set
  end

  it 'test de conmutatividad de &' do
    class A1; end
    class A2; end
    class A77789869; end    # esta NO tiene un 2
    class A777898269; end   # esta TIENE un 2 (esta escondido en el medio)
    class B1; end
    class B2; end
    class C1; end
    class C2; end
    class C3; end
    array_clases = [A1,A2,B1,B2,C1,C2,C3,A77789869,A777898269]
    jp1 = ClassName.new(array_clases, /A/)
    jp2 = ClassName.new(array_clases, /2/)
    pc1 = jp1 & jp2
    pc2 = jp2 & jp1
    pc1.match.should == pc2.match
  end

  it 'test de conmutatividad de |' do
    class A1; end
    class A2; end
    class A77789869; end    # esta NO tiene un 2
    class A777898269; end   # esta TIENE un 2 (esta escondido en el medio)
    class B1; end
    class B2; end
    class C1; end
    class C2; end
    class C3; end
    array_clases = [A1,A2,B1,B2,C1,C2,C3,A77789869,A777898269]
    jp1 = ClassName.new(array_clases, /A/)
    jp2 = ClassName.new(array_clases, /2/)
    pc1 = jp1 | jp2
    pc2 = jp2 | jp1
    pc1.match.should == pc2.match
  end

  # PARTE 2: RESULTADOS SOLO SOBRE NOMBRES DE METODOS

  # PARTE 3: RESULTADOS SOLO SOBRE NOMBRES DE PARAMETROS

  # PARTE 4: RESULTADOS SOBRE NOMBRES DE CLASES Y METODOS COMBINADOS

  # PARTE 5: RESULTADOS SOBRE NOMBRES DE METODOS Y PARAMETROS COMBINADOS

  # PARTE 6: RESULTADOS SOBRE NOMBRES DE CLASES, METODOS Y PARAMETROS COMBINADOS


end
