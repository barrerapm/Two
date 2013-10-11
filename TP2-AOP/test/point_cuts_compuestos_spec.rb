require 'rspec'
require_relative '../framework/point_cut'
require_relative '../framework/conditions/condition'
require_relative 'parameter_name_join_point_spec'
require_relative 'parameter_type_join_point_spec'

describe 'Tests de Pointcuts compuestos con subclases de JPs' do

  attr_accessor :point_cut, :metodo

  before(:each) do
    @point_cut = PointCut.new
    @metodo = ->(a,b,c) {}
  end

  it 'jp6 AND jp6' do
    jp6 = ParameterNameJoinPoint.new(:a)
    jp6_2 = ParameterNameJoinPoint.new(:b)
    point_cut.conditions << ConditionAnd.new(jp6)
    point_cut.conditions << ConditionAnd.new(jp6_2)
    # pp point_cut.conditions
    true.should == jp6.aplica?(nil, metodo)
    true.should == jp6_2.aplica?(nil, metodo)
    true.should == point_cut.aplica?(nil, metodo)
  end

end
