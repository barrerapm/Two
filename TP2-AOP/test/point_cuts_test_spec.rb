require 'rspec'
require_relative '../framework/point_cut'
require_relative './dummy_join_point'
require_relative '../framework/conditions/condition'

describe 'Test Point-Cuts' do

  attr_accessor :point_cut

  class Persona
    def decir_hola
      p 'hola'
    end
  end

  before(:each) do
    @point_cut = PointCut.new
  end

  it 'agregar join-point AND true' do
    dummy_join_point = DummyJoinPoint.new(true)
    another_dummy_join_point = DummyJoinPoint.new(true)
    @point_cut.conditions << ConditionAnd.new(dummy_join_point)
    @point_cut.conditions << ConditionAnd.new(another_dummy_join_point)
    true.should == @point_cut.aplica?(Persona, Persona.instance_methods(false).first)
  end

  it 'agregar join-point AND false' do
    dummy_join_point = DummyJoinPoint.new(true)
    another_dummy_join_point = DummyJoinPoint.new(false)
    @point_cut.conditions << ConditionAnd.new(dummy_join_point)
    @point_cut.conditions << ConditionAnd.new(another_dummy_join_point)
    false.should == @point_cut.aplica?(Persona, Persona.instance_methods(false).first)
  end

  it 'agregar join-point OR true' do
    dummy_join_point = DummyJoinPoint.new(true)
    another_dummy_join_point = DummyJoinPoint.new(false)
    @point_cut.conditions << ConditionAnd.new(dummy_join_point)
    @point_cut.conditions << ConditionOr.new(another_dummy_join_point)
    true.should == @point_cut.aplica?(Persona, Persona.instance_methods(false).first)
  end

  it 'agregar join-point OR false' do
    dummy_join_point = DummyJoinPoint.new(false)
    another_dummy_join_point = DummyJoinPoint.new(false)
    @point_cut.conditions << ConditionAnd.new(dummy_join_point)
    @point_cut.conditions << ConditionOr.new(another_dummy_join_point)
    false.should == @point_cut.aplica?(Persona, Persona.instance_methods(false).first)
  end

  it 'agregar join-point NOT true' do
    dummy_join_point = DummyJoinPoint.new(false)
    @point_cut.conditions << ConditionAnd.new(dummy_join_point, true)
    true.should == @point_cut.aplica?(Persona, Persona.instance_methods(false).first)
  end

  it 'agregar join-point NOT false' do
    dummy_join_point = DummyJoinPoint.new(true)
    @point_cut.conditions << ConditionAnd.new(dummy_join_point, true)
    false.should == @point_cut.aplica?(Persona, Persona.instance_methods(false).first)
  end

  it 'agregar join-point AND-OR-NOT true' do
    dummy_join_point = DummyJoinPoint.new(true)
    another_dummy_join_point = DummyJoinPoint.new(false)
    @point_cut.conditions << ConditionAnd.new(dummy_join_point)
    @point_cut.conditions << ConditionOr.new(dummy_join_point)
    @point_cut.conditions << ConditionAnd.new(another_dummy_join_point, true)
    true.should == @point_cut.aplica?(Persona, Persona.instance_methods(false).first)
  end

  it 'agregar join-point AND-OR-NOT false' do
    dummy_join_point = DummyJoinPoint.new(true)
    another_dummy_join_point = DummyJoinPoint.new(true)
    @point_cut.conditions << ConditionAnd.new(dummy_join_point)
    @point_cut.conditions << ConditionOr.new(dummy_join_point)
    @point_cut.conditions << ConditionAnd.new(another_dummy_join_point, true)
    false.should == @point_cut.aplica?(Persona, Persona.instance_methods(false).first)
  end


end