require_relative 'interceptor'

class InterceptorBefore < Interceptor

  def intercept(obj, metodo_origen, aspect, *args)
    context = create_context(obj, metodo_origen, *args)
    aspect.exec(context)
    obj.send metodo_origen, *args
  end

end