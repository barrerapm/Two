require 'rspec'
require_relative '../../framework/aspect'
require_relative '../../framework/join_points/class_regex'

describe 'Test de funcionamiento de los pointcuts con los aspectos' do

  class A
    def a1

    end
    def a2

    end
  end

  class B
    def b1

    end
    def b2

    end
  end

  class SomeAspect < Aspect

    def exec(context)

    end

  end

  it 'should retornar todos los metodos de A' do
    pointcut = ClassRegex.new(/A/)
    aspect = SomeAspect.new(pointcut)
    aspect.methods_to_intercept(A).sort.should == [:a1,:a2]
    aspect.methods_to_intercept(B).sort.should == []
  end


end