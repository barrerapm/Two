require_relative 'interceptor'

class InterceptorInsteadOf < Interceptor

  def intercept(obj, metodo_origen, aspect, *args)
    context = create_context(obj, metodo_origen, *args)
    aspect.exec(context)
  end

end