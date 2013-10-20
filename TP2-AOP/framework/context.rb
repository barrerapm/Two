class Context

  attr_accessor :object, :parameter_values, :method_origin, :exception

  #object: el objeto que esta siendo interceptado
  #parameter_values: map<Symbol, Object> contiene el valor de cada parametro
  #method_origin: Symbol - es el metodo en ejecucion
  #excepcion: excepcion generada en el metodo original

end