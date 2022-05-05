#!/usr/bin/env ruby
# Id$ nonnax 2022-05-05 16:48:33 +0800
require 'rack'
require_relative 'router'
require_relative 'view'

module Basic
  def self.set(&block)
    Router.set(&block)
  end
  class App
    class Response<Rack::Response; end
    def fetch(env, **opts)
      Router.fetch(env, **opts)
    end
    def render(page, **opts)
      View.render(page, **opts)
    end
  end
end
