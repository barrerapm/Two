require 'rspec'
require 'set'

base = '../../framework'

require_array = [
    'framework_aop',
    'join_points/class_name_2',
    'join_points/method_name_2',
    'join_points/parameter_name_2',
    'join_points/pointcut',
    'join_points/pointcut_bonus',
    'join_points/joinpoint_bonus',
]
require_array.each {|rb| require_relative base + '/' + rb}

describe 'Join points' do

  fwk = FrameworkAOP.instance
  jp1 = ClassName2.new(fwk.array_clases, /no_importa_este_texto/)
  jp2 = ClassName2.new(fwk.array_clases, /no_importa_este_texto/)

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
  it 'doble negacion de un Pointcut' do
    pc = ClassName2.new(fwk.array_clases, /Space/)
    pc.match.should == (~~pc).match
  end


  # BONUS: NO TERMINADO
  it 'Operaciones entre Pointcuts y luego reconstruir lo que quedo "dentro"' do
    puts 'Operaciones entre Pointcuts y luego reconstruir lo que quedo "dentro"'
    jp3 = ClassName2.new(fwk.array_clases, /no_importa_este_texto/)
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
    jp1 = ClassName2.new(array_clases, /A/)
    jp2 = ClassName2.new(array_clases, /2/)
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
    jp1 = ClassName2.new(array_clases, /A/)
    jp2 = ClassName2.new(array_clases, /2/)
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
    jp = ClassName2.new(array_clases, /2/)
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
    jp1 = ClassName2.new(array_clases, /A/)
    jp2 = ClassName2.new(array_clases, /2/)
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
    jp1 = ClassName2.new(array_clases, /A/)
    jp2 = ClassName2.new(array_clases, /2/)
    pc1 = jp1 | jp2
    pc2 = jp2 | jp1
    pc1.match.should == pc2.match
  end

  it 'dos & en serie' do
    class A1; end
    class A2; end
    class B1; end
    class B2; end
    class AB1; end
    class AB2; end
    array_clases = [A1,A2,B1,B2,AB1,AB2]
    jp1 = ClassName2.new(array_clases, /2/)
    jp2 = ClassName2.new(array_clases, /B/)
    jp3 = ClassName2.new(array_clases, /A/)
    pc1 = jp1 & jp2
    pc2 = pc1 & jp3
    # esto demuestra que guardar el result de un & y luego hacer otro & con ese result y guardarlo
    # da lo mismo que hacer 2 & seguidos (en serie)
    (jp1 & jp2 & jp3).match.should == pc2.match
    (jp1 & jp2 & jp3).match.should == [AB2].to_set
  end


  # PARTE 2: RESULTADOS SOLO SOBRE NOMBRES DE METODOS
  it 'nombres de metodos' do

    class A
      def m1; end
      def m2; end
    end
    class B
      def m1; end
    end
    class C
      def m2; end
    end

    array_clases = [A,B,C]
    jp1 = MethodName2.new(array_clases, /m1/)
    jp2 = MethodName2.new(array_clases, /m2/)
    jp1.match.should == [A,B].to_set
    jp2.match.should == [A,C].to_set
    (jp1 & jp2).match.should == [A].to_set
    (jp1 | jp2).match.should == [A,B,C].to_set

  end


  # PARTE 3: RESULTADOS SOLO SOBRE NOMBRES DE PARAMETROS
  it 'nombres de parametros' do

    class A
      def m1(p1,p2); end
      def m2(p3,p4); end
    end
    class B
      def m1(p1,p3); end
    end
    class C
      def m2(p2,p4); end
    end

    array_clases = [A,B,C]
    jp1 = ParameterName2.new(array_clases, /p1/)
    jp2 = ParameterName2.new(array_clases, /p2/)
    jp3 = ParameterName2.new(array_clases, /p3/)
    jp4 = ParameterName2.new(array_clases, /p4/)
    jp1.match.should == [A,B].to_set
    jp2.match.should == [A,C].to_set
    jp3.match.should == [A,B].to_set
    jp4.match.should == [A,C].to_set
    (jp1 & jp2).match.should == [A].to_set
    (jp1 & jp3).match.should == [A,B].to_set
    (jp1 & jp4).match.should == [A].to_set
    (jp1 & jp2 & jp3).match.should == [A].to_set
    (jp1 & jp2 & jp3 & jp4).match.should == [A].to_set
    (jp1 | jp2).match.should == [A,B,C].to_set
    (jp3 | jp4).match.should == [A,B,C].to_set
    (jp1 | jp3).match.should == [A,B].to_set
    (jp2 | jp4).match.should == [A,C].to_set

  end


  # PARTE 4: RESULTADOS SOBRE NOMBRES DE CLASES Y METODOS COMBINADOS
  it 'combo clases y metodos' do

    class A
      def m1(p1,p2); end
      def m2(p3,p4); end
    end
    class B
      def m1(p1,p3); end
    end
    class C
      def m2(p2,p4); end
    end

    array_clases = [A,B,C]
    jpA = ClassName2.new(array_clases, /A/)
    jpB = ClassName2.new(array_clases, /B/)
    jpC = ClassName2.new(array_clases, /C/)
    jp_m2 = MethodName2.new(array_clases, /m2/)

    (jpA & jp_m2).match.should == [A].to_set
    (jpB & jp_m2).match.should == [].to_set
    (jpC & jp_m2).match.should == [C].to_set

  end


  # PARTE 5: RESULTADOS SOBRE NOMBRES DE METODOS Y PARAMETROS COMBINADOS
  it 'combo metodos y parametros' do

    class A
      def m1(p1,p2); end
      def m2(p3); end
    end
    class B
      def m1(p1,p3); end
    end
    class C
      def m2(p2,p4); end
    end
    class D
      def m1; end
      def m2; end
    end

    array_clases = [A,B,C,D]
    jp_m1 = MethodName2.new(array_clases, /m1/)
    jp_m2 = MethodName2.new(array_clases, /m2/)
    jp_p1 = ParameterName2.new(array_clases, /p1/)
    jp_p2 = ParameterName2.new(array_clases, /p2/)
    jp_p3 = ParameterName2.new(array_clases, /p3/)
    jp_p4 = ParameterName2.new(array_clases, /p4/)

    jp_m2.match.should == [A,C,D].to_set
    (jp_m1 & jp_p1).match.should == [A,B].to_set
    (jp_m2 & jp_p2).match.should == [A,C].to_set
    (jp_m2 & jp_p4).match.should == [C].to_set

  end


  # PARTE 6: RESULTADOS SOBRE NOMBRES DE CLASES, METODOS Y PARAMETROS COMBINADOS
  it 'combo metodos y parametros' do

    class A
      def m1(p1,p2); end
      def m2(p3); end
    end
    class B
      def m1(p1,p3); end
    end
    class C
      def m2(p2,p4); end
    end
    class D
      def m1; end
      def m2; end
    end

    array_clases = [A,B,C,D]
    jp_A = ClassName2.new(array_clases, /A/)
    jp_m1 = MethodName2.new(array_clases, /m1/)
    jp_m2 = MethodName2.new(array_clases, /m2/)
    jp_p1 = ParameterName2.new(array_clases, /p1/)
    jp_p2 = ParameterName2.new(array_clases, /p2/)
    jp_p3 = ParameterName2.new(array_clases, /p3/)
    jp_p4 = ParameterName2.new(array_clases, /p4/)

    (jp_m2 & jp_p1).match.should == [A].to_set
    # aca surge un temita: A tiene m2 y p3, pero m2(p3) no pertenece a la clase A
    # me parece que el enunciado del TP era "mas abierto" y pedia la funcionalidad que esta ocurriendo
    # en este test, pero no la funcionalidad EXACTA de matchear ESTE METODO Y ESTE PARAMETRO (a la vez)
    (jp_m1 & jp_p3).match.should == [A,B].to_set

  end

end
