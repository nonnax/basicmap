#!/usr/bin/env ruby
# Id$ nonnax 2022-03-01 15:27:49 +0800
class View
  def initialize(page, **data)
    @data = data
    
    layout, template = ['layout', page].map do |f|
      File.join( File.dirname(__FILE__), "../public/views/#{f}.erb" )
    end
    
    @template = File.read(template)
    @layout = File.read(layout)
  end

  def visit_count
    @data[:visit_count]
  end

  def render
    [@template, @layout].inject("") do |temp, f|
      _render(f){temp}
    end
  end

  def _render(f)
    ERB.new(f).result(binding)
  end
end
