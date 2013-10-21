require_relative 'interceptor'

class InterceptorAfter < Interceptor

  def intercept(obj, metodo_origen, aspect, *args)
    context = create_context(obj, metodo_origen, *args)
    result = obj.send metodo_origen, *args
    aspect.exec(context)
    result
  end

end