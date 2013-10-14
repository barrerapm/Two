class FrameworkAOP

  attr_accessor :aspectos

  def initialize
    @aspectos = Array.new
  end

  def agregar_aspecto(aspecto)

  end

  def listMethods(aClass)
    puts aClass.to_s
    aClass.instance_methods(false).each do
      |met|
      puts met.to_s

    end
  end

  def listar_clases_y_metodos
    ObjectSpace.each_object(Class).each do
      |clazz|
      p clazz.to_s
      listMethods(clazz)
    end
  end

  def aplicar_advices
    ObjectSpace.each_object(Class).each do
      |clazz|
      clazz.instance_methods(false).each do
        |metodo|
        @aspectos.each do
          |aspecto|
          if(aspecto.point_cut.aplica?(clazz, metodo))
            aspecto.aplicar(clazz, metodo)
          end
        end
      end
    end
  end

end