require_relative '../aspects/cache_sin_estado'

class InvocacionConEstado < InvocacionSinEstado
  attr_accessor :atributos
  def initialize(ctx,resultado)
    super(ctx, resultado)
    @atributos = ctx.object.instance_variables.map{|iv| ctx.object.instance_variable_get(iv)}
  end
end

class CacheConEstadoAspect < CacheSinEstadoAspect

  def initialize
    super
    @clase_de_invocacion = InvocacionConEstado
  end

  def validar_invocacion_en_cache(invocacion, contexto)
    super(invocacion, contexto) &&
          contexto.object.instance_variables.map{|iv|
                contexto.object.instance_variable_get(iv)}.eql?(invocacion.atributos)
  end

end
