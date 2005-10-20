require 'rake'
task :default => [:example]

desc 'run the example'
task :example do
  sh 'ruby -Ilib bin/radp examples/hans.radp'
end

task :install do
  sh 'ruby setup.rb config --prefix=/usr/local'
  sh 'sudo ruby setup.rb install'
end

# vim: filetype=ruby
