#!/usr/bin/env ruby
# Id$ nonnax 2022-04-25 15:31:55 +0800
require 'benchmark'

desc 'compile scss'
task :c do
  Dir.chdir 'scss' do
    sh 'sass.rb style.scss > ../public/css/style.css'
  end
end

desc 'run test'
task :test do
  sh 'ruby test.rb'
end
