require_relative '../framework/aspect'

class CacheConEstadoAspect < Aspect

  attr_accessor :array_invocaciones_cache_con_estado

  def initialize
    @array_invocaciones_cache_con_estado = []
  end

  def exec(context)
    ejecutar_metodo(context)
  end

  def ejecutar_metodo(context)
    metodo_en_cache = buscar_metodo_en_cache(context)
    if metodo_en_cache == nil
      agregar_y_ejecutar_metodo_en_cache(context)
    else
      puts 'Esta en cache: ' + metodo_en_cache.resultado.to_s
      metodo_en_cache.resultado
    end
  end

  def methods_to_intercept(clase)
    clase.instance_methods(false).keep_if do |method|
      method.to_s == 'nacimiento'
    end
  end

  def buscar_metodo_en_cache(ctx)
    if not @array_invocaciones_cache_con_estado.empty?
    @array_invocaciones_cache_con_estado.detect {
    |inv| inv.metodo.to_s == ctx.method_origin.to_s &&
          inv.argumentos.eql?(ctx.parameter_values) &&
          ctx.object.instance_variables.map{|iv| ctx.object.instance_variable_get(iv)}.eql?(inv.atributos)
    }
    end
  end

  def agregar_y_ejecutar_metodo_en_cache(context)
    resultado = context.object.send context.method_origin, *context.parameter_values.map {|param| param[1]}.to_set
    @array_invocaciones_cache_con_estado << InvocacionConEstado.new(context, resultado)
    puts 'No estaba en cache, agregado: ' + resultado.to_s
    resultado
 end

  class InvocacionConEstado
    attr_accessor :metodo, :argumentos, :resultado, :atributos
    def initialize(ctx,resultado)
      @metodo = ctx.method_origin
      @argumentos = ctx.parameter_values
      @resultado = resultado
      @atributos = ctx.object.instance_variables.map{|iv| ctx.object.instance_variable_get(iv)}
    end
  end




end