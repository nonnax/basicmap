#!/usr/bin/env ruby
# frozen_string_literal: true

# Id$ nonnax 2022-03-01 15:27:49 +0800
require 'erb'
class View
  attr :layout, :template
  def self.render(page, **data)
    new(page, **data).render
  end

  def initialize(page, **data)
    @data = data

    l, t = [:layout, page].map do |f|
      File.join(File.dirname(__FILE__), "../public/views/#{f}.erb")
    end

    @template = File.read(t) rescue page
    @layout   = File.read(l) rescue '<%=yield%>'
  end

  def render
    [template, layout].inject('') do |temp, f|
      _render(f) { temp }
    end
  end

  def _render(f)
    ERB.new(f).result(binding)
  end
end
