#!/usr/bin/ruby
require 'radp'

class ExtensionGenerator
  def extensions(radp,context)
    # replace this with your own magic
    radp.context context do
      101.upto(110) do |i|
	radp.ext i do 
	  radp.dial("SIP/x#{i}")
	end
      end
    end
  end
end
eg = ExtensionGenerator.new

class RADP
  def dial(*args)
    n = Dial(args)
    Congestion()
    @p = n+101
    Busy()
  end
end

RADP.new do |radp|
  radp.context :default do
    radp.ext :s do
      radp.answer
      radp.playback 'chunky-bacon'
      radp.hangup
    end
  end
  eg.extensions(radp, :employees)
end


# vim: filetype=ruby
