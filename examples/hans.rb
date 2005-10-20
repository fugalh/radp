require 'radp'

# incoming
context 'default' do
  includes 'home'
end

context 'test' do
  ext 'c' do goto('conference','s',1) end
  includes 'home'
end

context 'from-sipura' do
  ext '_18668247977' do goto('home','s',2) end
  includes 'iaxtel'
  includes 'nufone'
  ext 0 do goto('menu','s',1) end 
  ext '*' do voicemailmain('s77') end 
end

context 'from-nufone' do
  ext 8668247977 do goto('home','s',1) end
  ext 8662238801 do goto('home','s',1) end
end

context 'from-zap' do
  includes 'home'
  ext 's/' do goto('desconocido','s',1) end
end

context 'desconocido' do
  ext 's' do 
      answer
      wait 1
      zapateller
      background('custom/desconocido')
      waitext 5
      hangup
  end
  ext '#' do 
      voicemail('77&80')
      hangup
  end
  ext '*' do goto('home','s',1) end
end

# outgoing
context 'zap' do
  ext '_NXXXXXX' do 
    dial('Zap/1/${ext}')
    congestion
  end

  %w{800 866 877 888}.each do |x|
    ext "_1#{x}NXXXXXX" do
      dial('Zap/1/${ext}')
      congestion
    end
  end
end

context 'home' do
  ext 's' do
      dial('SIP/sipura',30)
      answer
      wait(1)
      background('custom/zarvox')
      voicemail('s77&80')
      hangup
  end
  ext 'a' do voicemailmain end
end

context 'nufone' do
  ext '_NXXXXXX' do 
    setcidnum(8668247977)

    n = dial('IAX2/NuFone/1505${ext}')
    congestion

    priority = n+101
    busy
  end
  ext '_1NXXNXXXXXX' do 
    setcidnum(8668247977)

    n = dial 'IAX2/NuFone/${ext}' 
    congestion

    priority = n+101
    busy
  end
end

context 'iaxtel' do
  #%w{700 888 877 866 800}.each do |x|
  %w{700}.each do |x|
    ext "_1#{x}NXXXXXX" do dial('IAX2/fugalh:secret@iaxtel.com/${ext}@iaxtel') end
  end
end

context 'menu' do
  ext 's' do 
    background('custom/menu')
    wait(5)
    goto 1
  end
  ext '*' do voicemailmain end 
  %w{53 56 77 79 80 82 83 86 90 04}.each do |x|
    ext x do voicemail(x) end
  end
  ext 613 do dial 'SIP/fwd.pulver.com/613' end
  ext 500 do 
    dial 'IAX2/guest@misery.digium.com/s@default'
    playback 'demo-nogo' # Couldn't connect to the demo site
  end
  ext 600 do goto('conference','s',1) end
end


context 'conference' do
  ext 's' do 
    answer
    meetme(600,'i')
  end
end

context 'fc' do
  ext 's' do 
    dial('SIP/sipura',3)
    answer
    voicemail(77)
    hangup
  end
  ext 'a' do voicemailmain end
end
