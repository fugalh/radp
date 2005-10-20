require 'ostruct'

# Ruby Asterisk Dial Plan
class RADP
  def initialize(io=$stdout,&block)
    @io = io
    instance_eval &block if block_given?
  end

  def context(name)
    @io.puts "[#{name}]"
    yield if block_given?
    @io.puts
  end

  def ext(name,&block)
    @extension = name
    @priority = 1
    instance_eval &block if block_given?
  end

  def includes(name)
    @io.puts "include => #{name}"
  end

  def switch(name)
    @io.puts "switch => #{name}"
  end

  def method_missing(name,*args)
    p = @priority.to_i
    @io.puts "exten => #{@extension},#{p},#{name}(#{args.join ', '})"
    @priority += 1
    return p
  end
end
