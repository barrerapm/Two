require_relative '../framework/interceptors/interceptor'

class InterceptorDSL  < Interceptor

  def intercept(obj, metodo_origen, aspect_dsl, *args)
    context = create_context(obj, metodo_origen, *args)
    begin
      aspect_dsl.exec_before context
      result = obj.send metodo_origen, *args
      aspect_dsl.exec_after context
    rescue Exception => e
      context.exception = e
      aspect_dsl.exec_on_exception context
      raise e
    end
    result
  end

end