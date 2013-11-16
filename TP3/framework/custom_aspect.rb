require_relative '../framework/aspect'

class CustomAspect < Aspect

  def define_exec(&block)
    @exec_block = block
  end

  def exec(context)
    @exec_block.call context
  end

end