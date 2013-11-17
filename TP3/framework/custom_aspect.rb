require_relative '../framework/aspect'

class CustomAspect < Aspect

  def define_exec(&block)
    @exec_block = block
  end

  def before_block(&block)
    @before_block = block
  end

  def after_block(&block)
    @after_block = block
  end

  def on_exception_block(&block)
    @on_exception_block = block
  end

  def exec_before(context)
    @before_block.call context
  end

  def exec_after(context)
    @after_block.call context
  end

  def exec_on_exception(context)
    @on_exception_block.call context
  end

  def exec(context)
    @exec_block.call context
  end

end