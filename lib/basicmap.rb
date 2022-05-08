#!/usr/bin/env ruby
# frozen_string_literal: true

# Id$ nonnax 2022-05-05 16:00:11 +0800
require 'rack'
require_relative 'router'
require_relative 'view'

module Basic
  def self.routes(&block)
    Router.instance_eval(&block)
  end

  def self.views(&block)
    View.instance_eval(&block)
  end

  class App
    class Response < Rack::Response; end

    attr :req, :env, :res

    def fetch(env, **opts)
      r = Router::fetch(env, **opts)
      res.status = r.status
      if respond_to?(r.method) && res.status != 404
        send(
          r.method,
          r.name,
          req.params.transform_keys(&:to_sym)
        )
      else
        respond_to?(:default) ? send(:default) : 'Not Found'
      end
    end

    def erb(page, **opts)
      View::erb(page, **opts)
    end

    def halt(app)
      throw :halt, app.finish
    end

    def call(env)
      @req  = Rack::Request.new(env)
      @res  = Rack::Response.new(nil, 200, { 'Content-Type' => 'text/html; charset=utf-8;', 'Cache-Control' => 'public, max-age=86400' })
      @env  = env
      catch(:halt) do
        res.write fetch(env)
        res.finish
      end
    end
  end
end
