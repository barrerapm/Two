require_relative 'join_points/class_name'

class Framework

  def initialize(array_clases)
    @array_clases = array_clases
  end

  def matchClassName(regex)
    jp = ClassName.new(@array_clases, regex)
  end

end

# TODO: BORRAR: TEST CHOTO ASI NOMAS
fwk = Framework.new(ObjectSpace.each_object(Class).to_a)  # pasarlo como array y no como enum al Framework
