require_relative 'interceptor'

class InterceptorOnError < Interceptor

  def intercept(obj, metodo_origen, aspect, *args)
    context = create_context(obj, metodo_origen, *args)
    begin
      obj.send metodo_origen, *args
    rescue Exception => e
      context.exception = e
      aspect.exec(context)
      raise e
    end
  end

end