require_relative '../../framework/context'

class Interceptor

  def create_context(obj, metodo_origen, *args)
    context = Context.new
    context.object = obj
    context.method_origin = metodo_origen
    context.parameter_values = create_map_parameters(obj.method(metodo_origen), *args)
    return context
  end

  def create_map_parameters(metodo, *args)
    map_parameters = {}
    metodo.parameters.each do |param|
      map_parameters[param[1]] = args[map_parameters.length]
    end
    return map_parameters
  end

end