require 'rspec'
require_relative '../../framework/join_points/custom'

describe 'Test Custom JP' do

  lambda = ->(a,b) {}
  jp = Custom.new {|metodo| metodo.is_a? Proc}

  it 'va a devolver true porque lambda es clase Proc' do
    true.should == jp.match?(nil, lambda)
  end

end