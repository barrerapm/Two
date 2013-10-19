require_relative 'join_point'

class ClassName < Joinpoint

  def initialize(enum_clases, regex)
    @array_clases = enum_clases
    @regex = regex
  end

  def match
    @array_clases.collect {|c| c.name =~ @regex}
  end

end


# TODO: BORRAR: TEST CHOTO
p 'JP'

clases = ObjectSpace.each_object(Class)
jp1 = ClassName.new(clases, /Class/)
jp2 = ClassName.new(clases, /Mongo/)
pc1 = jp1 & jp2
#p pc1
pc1.match
#p (~jp).match
