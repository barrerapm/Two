require 'rspec'
require_relative '../framework/custom_join_point'

describe 'Test Custom JP' do

  lambda = ->(a,b) {}
  jp = CustomJoinPoint.new {|metodo| metodo.is_a? Proc}

  it 'va a devolver true porque lambda es clase Proc' do
    true.should == jp.aplica?(nil, lambda)
  end

end