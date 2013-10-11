require 'rspec'
require_relative '../framework/point_cut'
require_relative '../framework/conditions/condition'
require_relative 'parameter_name_join_point_spec'
require_relative 'parameter_type_join_point_spec'

describe 'Pointcuts compuestos con subclases de JPs' do

  attr_accessor :point_cut, :metodo

  before(:each) do
    @point_cut = PointCut.new
  end

  it 'jp6 AND jp6, orden :a :b' do
    metodo = ->(a,b,c) {}
    jp6 = ParameterNameJoinPoint.new(:a)
    jp6_2 = ParameterNameJoinPoint.new(:b)
    point_cut.conditions << ConditionAnd.new(jp6)
    point_cut.conditions << ConditionAnd.new(jp6_2)
    # pp point_cut.conditions
    true.should == jp6.aplica?(nil, metodo)
    true.should == jp6_2.aplica?(nil, metodo)
    true.should == point_cut.aplica?(nil, metodo)
  end

  it 'jp6 AND jp6, orden :b :a' do
    metodo = ->(b,a,c) {}
    jp6 = ParameterNameJoinPoint.new(:a)
    jp6_2 = ParameterNameJoinPoint.new(:b)
    point_cut.conditions << ConditionAnd.new(jp6)
    point_cut.conditions << ConditionAnd.new(jp6_2)
    # pp point_cut.conditions
    true.should == jp6.aplica?(nil, metodo)
    true.should == jp6_2.aplica?(nil, metodo)
    true.should == point_cut.aplica?(nil, metodo)
  end

  it 'jp6 AND jp6  :a :b :c' do
    metodo = ->(a,b,c) {}
    jp6 = ParameterNameJoinPoint.new(:a)
    jp6_2 = ParameterNameJoinPoint.new(:b)
    jp6_3 = ParameterNameJoinPoint.new(:c)
    point_cut.conditions << ConditionAnd.new(jp6)
    point_cut.conditions << ConditionAnd.new(jp6_2)
    point_cut.conditions << ConditionAnd.new(jp6_3)
    # pp point_cut.conditions
    true.should == jp6.aplica?(nil, metodo)
    true.should == jp6_2.aplica?(nil, metodo)
    true.should == jp6_3.aplica?(nil, metodo)
    true.should == point_cut.aplica?(nil, metodo)
  end

  it 'jp6 AND jp6   :a :b :c :d' do
    metodo = ->(a,b,c) {}
    jp6 = ParameterNameJoinPoint.new(:a)
    jp6_2 = ParameterNameJoinPoint.new(:b)
    jp6_3 = ParameterNameJoinPoint.new(:c)
    jp6_4 = ParameterNameJoinPoint.new(:d)
    point_cut.conditions << ConditionAnd.new(jp6)
    point_cut.conditions << ConditionAnd.new(jp6_2)
    point_cut.conditions << ConditionAnd.new(jp6_3)
    point_cut.conditions << ConditionAnd.new(jp6_4)
    # pp point_cut.conditions
    true.should == jp6.aplica?(nil, metodo)
    true.should == jp6_2.aplica?(nil, metodo)
    true.should == jp6_3.aplica?(nil, metodo)
    false.should == jp6_4.aplica?(nil, metodo)
    false.should == point_cut.aplica?(nil, metodo)
  end

end
