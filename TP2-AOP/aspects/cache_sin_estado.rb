require_relative '../framework/aspect'

class InvocacionSinEstado
  attr_accessor :metodo, :argumentos, :resultado

  def initialize(contexto,resultado)
    @metodo = contexto.method_origin
    @argumentos = contexto.parameter_values
    @resultado = resultado
  end
end

class CacheSinEstadoAspect < Aspect

  attr_accessor :array_invocaciones

  def initialize
    @array_invocaciones = []
  end

  def exec(contexto)
    metodo_en_cache = buscar_metodo_en_cache(contexto)
    if metodo_en_cache == nil
      agregar_y_ejecutar_metodo_en_cache(contexto)
      puts 'Agregado a cache'
    else
      puts 'Invocado desde cache '
      metodo_en_cache.resultado
    end
  end

  def buscar_metodo_en_cache(contexto)
    if not @array_invocaciones.empty?
      @array_invocaciones.detect {
          |invocacion| validar_invocacion_en_cache(invocacion, contexto)
      }
    end
  end

  def validar_invocacion_en_cache(invocacion, contexto)
    invocacion.metodo.to_s == contexto.method_origin.to_s &&
        invocacion.argumentos.eql?(contexto.parameter_values)
  end

  def agregar_y_ejecutar_metodo_en_cache(contexto)
    resultado = contexto.object.send contexto.method_origin, *contexto.parameter_values.map {|param| param[1]}.to_set
    @array_invocaciones << InvocacionSinEstado.new(contexto, resultado)
    resultado
  end

end
