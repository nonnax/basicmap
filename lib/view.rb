#!/usr/bin/env ruby

# Id$ nonnax 2022-03-01 15:27:49 +0800
require 'erb'
class View
  @settings = {}
  @settings[:views]='public/views'
  @settings[:layout]='layout'

  attr :data, :params

  def self.erb(page, **data)
    new(page, **data).erb
  end

  def self.settings
    @settings
  end

  def settings
    self.class.settings
  end

  def initialize(page, **opts)
    @params = @data = opts.dup
    layout = params.fetch(:layout, settings[:layout])
    l, t = [layout, page].map do |f|
      File.join(Dir.pwd, "#{settings[:views]}/#{f}.erb")
    end

    @template = File.read(t) rescue page
    @layout   = File.read(l) rescue '<%=yield%>'
  end

  def erb
    _render(@layout) { _render(@template, binding) }
  end

  def _render(f, b=binding)
    ERB.new(f).result(b)
  end
end

