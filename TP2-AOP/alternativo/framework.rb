require_relative 'join_points/class_name'

class Framework

  # en caso de querer instanciarlo con otra cosa que no sea ObjectSpace, pasarlo como array (no como enum) al Framework
  def initialize(array_clases=ObjectSpace.each_object(Class).to_a)
    @array_clases = array_clases
  end

  def matchClassName(regex)
    jp = ClassName.new(@array_clases, regex)
  end

end
