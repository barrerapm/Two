require 'rspec'
require_relative '../framework/join_points/join_point'
require_relative '../framework/point_cut'
#require_relative 'conditions/condition'
require_relative '../framework/join_points/parameter_name'
require_relative '../framework/join_points/parameter_type'

describe 'Pointcuts compuestos con subclases de JPs' do

  attr_accessor :point_cut, :metodo

  puts 'Pointcuts compuestos con subclases de JPs'

  before(:each) do
    @point_cut = PointCut.new
  end

  it 'jp6 AND jp6, orden :a :b' do
    metodo = ->(a,b,c) {}
    jp6 = ParameterName.new(:a)
    jp6_2 = ParameterName.new(:b)
    point_cut.conditions << ConditionAnd.new(jp6)
    point_cut.conditions << ConditionAnd.new(jp6_2)
    # pp point_cut.conditions
    true.should == jp6.aplica?(nil, metodo)
    true.should == jp6_2.aplica?(nil, metodo)
    true.should == point_cut.aplica?(nil, metodo)
  end

  it 'jp6 AND jp6, orden :b :a' do
    metodo = ->(b,a,c) {}
    jp6 = ParameterName.new(:a)
    jp6_2 = ParameterName.new(:b)
    point_cut.conditions << ConditionAnd.new(jp6)
    point_cut.conditions << ConditionAnd.new(jp6_2)
    # pp point_cut.conditions
    true.should == jp6.aplica?(nil, metodo)
    true.should == jp6_2.aplica?(nil, metodo)
    true.should == point_cut.aplica?(nil, metodo)
  end

  it 'jp6 AND jp6  :a :b :c' do
    metodo = ->(a,b,c) {}
    jp6 = ParameterName.new(:a)
    jp6_2 = ParameterName.new(:b)
    jp6_3 = ParameterName.new(:c)
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
    jp6 = ParameterName.new(:a)
    jp6_2 = ParameterName.new(:b)
    jp6_3 = ParameterName.new(:c)
    jp6_4 = ParameterName.new(:d)
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
