require 'rspec'
require_relative '../joinpoint'
require_relative '../class_name'

describe 'Join points' do

  it 'debe...' do

    jp1 = ClassName.new(/hola/)
    jp2 = ClassName.new(/hola/)
    (jp1 & jp2).class.should == Pointcut

  end
end