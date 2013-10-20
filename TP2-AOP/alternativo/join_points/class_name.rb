require 'set'
require_relative 'joinpoint'

class ClassName < Joinpoint

  def initialize(array_clases, regex)
    @array_clases = array_clases
    @regex = regex
  end

  def match
    @array_clases.select {|c| c.name =~ @regex}.to_set
  end

end
