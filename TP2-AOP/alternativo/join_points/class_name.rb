require_relative 'joinpoint'

class ClassName < Joinpoint

  def initialize(enum_clases, regex)
    @array_clases = enum_clases
    @regex = regex
  end

  def match
    @array_clases.collect {|c| c.name =~ @regex}
  end

end
