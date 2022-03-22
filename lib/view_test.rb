#!/usr/bin/env ruby
# Id$ nonnax 2022-03-01 15:27:49 +0800
require 'erb'
require './view'

page,*data=ARGV

puts View
  .new(page, data: data)
  .render
  .gsub(/\n{2,}/,'' )
