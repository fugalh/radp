require 'ostruct'
DialPlan = OpenStruct.new
DialPlan.target = ""

def context(name)
  DialPlan.target << "[#{name}]\n"
  yield if block_given?
  DialPlan.target << "\n"
end

def ext(name)
  DialPlan.extension = name
  DialPlan.priority = 1
  yield if block_given?
end

def method_missing(name,*args)
  p = DialPlan.priority.to_i
  DialPlan.target << "exten => #{DialPlan.extension},#{p},#{name}(#{args.join ', '})\n"
  DialPlan.priority += 1
  return p
end

def includes(name)
  DialPlan.target << "include => #{name}\n"
end

def switch(name)
  DialPlan.target << "switch => #{name}\n"
end

END {
  puts DialPlan.target
}
