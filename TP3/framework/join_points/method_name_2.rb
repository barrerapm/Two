require 'set'

base = '..'
require_array = ['join_points/join_point']
require_array.each {|rb| require_relative base + '/' + rb}

class MethodName2 < JoinPoint

  def initialize(array_clases, regex)
    @array_clases = array_clases
    @regex = regex
  end

  def match
    @array_clases.select {|c| c.instance_methods(false).any? {
        |m| m.to_s =~ @regex} }.to_set
  end

end
