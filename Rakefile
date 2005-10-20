require 'rake'
task :default => [:examples]

desc 'run the examples'
task :examples do
  sh 'ruby -Ilib bin/radp examples/simple.radp'
  sh 'ruby -Ilib examples/complex.rb'
end

task :install do
  sh 'ruby setup.rb config --prefix=/usr/local'
  sh 'sudo ruby setup.rb install'
end

task :doc do
  sh 'rdoc -x _darcs -x setup.rb -S -m README README lib/ bin/radp'
end

# vim: filetype=ruby
