require 'set'

base = '../../framework'
require_relative base + '/' + 'join_points/join_point'

class ClassName < JoinPoint

  def initialize(array_clases, regex)
    @array_clases = array_clases
    @regex = regex
  end

  def match
    @array_clases.select {|c| c.name =~ @regex}.to_set
  end

end
