require_relative '../framework/interceptors/interceptor'

class InterceptorDSL  < Interceptor

  attr_accessor :aspect_dsl

  def intercept(obj, metodo_origen, aspect, *args)
    context = create_context(obj, metodo_origen, *args)
    begin
      aspect_dsl.before_block.call context
      result = obj.send metodo_origen, *args
      aspect_dsl.after_block.call context
    rescue Exception => e
      context.exception = e
      aspect_dsl.on_exception.call context
      raise e
    end
    result
  end

end