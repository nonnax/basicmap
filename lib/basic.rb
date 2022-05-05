#!/usr/bin/env ruby
# Id$ nonnax 2022-05-05 16:00:11 +0800
require 'rack'
require_relative 'router'
require_relative 'view'

module Basic
  def self.set(k, v)
    Router::ROUTES[k]=v
  end

  def self.routes(&block)
    instance_eval(&block)
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
