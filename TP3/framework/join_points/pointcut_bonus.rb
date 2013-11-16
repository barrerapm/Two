class Pointcut

  # NOTA: ignoren este metodo! No se usa! Era parte de un BONUS que quise hacer, capaz despues lo termino
  def reconstruir(string)
    if @operador == :not then  # esta distincion es porque not es de aridad 1
      if op_izquierdo.class == Pointcut then
        string << "#{@operador} ("
      else
        string << "#{@operador} (#{@op_izquierdo.reconstruir(string)})"
      end
    else     # para and y or
      if op_izquierdo.class == Pointcut then
        #@op_izquierdo.reconstruir(string)
        string << "( #{@operador} #{@op_derecho.reconstruir(string)})"
      else
        string << "(#{@op_izquierdo.reconstruir(string)} #{@operador} #{@op_derecho.reconstruir(string)})"
      end
    end
    self
  end

  # NOTA: ignoren este metodo! No se usa! Era parte de un BONUS que quise hacer, capaz despues lo termino
  def to_string
    s = ''
    reconstruir(s)
    s
  end

end
