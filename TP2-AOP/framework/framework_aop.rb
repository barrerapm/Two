class FrameworkAOP

  def listMethods(aClass)
    puts aClass.to_s
    aClass.instance_methods(false).each do
      |met|
      puts met.to_s

    end
  end

end