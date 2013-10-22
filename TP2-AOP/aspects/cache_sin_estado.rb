require_relative '../framework/aspect'

class CacheSinEstadoAspect < Aspect

  attr_accessor :array_invocaciones_cache_sin_estado

  def initialize
    @array_invocaciones_cache_sin_estado = []
  end

  def exec(context)
    ejecutar_metodo(context)
  end

  def ejecutar_metodo(context)
    metodo_en_cache = buscar_metodo_en_cache(context)
    if metodo_en_cache == nil
      agregar_y_ejecutar_metodo_en_cache(context)
      puts 'Agregado a cache'
    else
      puts 'Invocado desde cache ' + metodo_en_cache.metodo.to_s
      metodo_en_cache.resultado
    end
  end

  def buscar_metodo_en_cache(ctx)
    if not @array_invocaciones_cache_sin_estado.empty?
      @array_invocaciones_cache_sin_estado.detect {
          |inv| inv.metodo.to_s == ctx.method_origin.to_s &&
            inv.argumentos.eql?(ctx.parameter_values)
      }
    end
  end

  def agregar_y_ejecutar_metodo_en_cache(context)
    resultado = context.object.send context.method_origin, *context.parameter_values.map {|param| param[1]}.to_set
    @array_invocaciones_cache_sin_estado << InvocacionConEstado.new(context, resultado)
    resultado
  end

  class InvocacionConEstado
    attr_accessor :metodo, :argumentos, :resultado, :atributos
    def initialize(ctx,resultado)
      @metodo = ctx.method_origin
      @argumentos = ctx.parameter_values
      @resultado = resultado
    end
  end

  def methods_to_intercept(clase)
    clase.instance_methods(false).keep_if do |method|
      method.to_s == 'caminar'
    end
  end


end
