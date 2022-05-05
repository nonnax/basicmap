#!/usr/bin/env ruby
# frozen_string_literal: true

# Id$ nonnax 2022-05-05 16:00:11 +0800
require 'rack'
require_relative 'router'
require_relative 'view'

module Basic
  def self.set(k, v)
    Router::ROUTES[k] = v
  end

  def self.routes(&block)
    instance_eval(&block)
  end

  class App
    class Response < Rack::Response; end

    attr :req, :env

    def fetch(env, **opts)
      Router.fetch(env, **opts)
    end

    def erb(page, **opts)
      View.erb(page, **opts)
    end

    def call(env)
      @req  = Rack::Request.new(env)
      @env  = env
      @body = get
      [@status, { 'Content-Type' => 'text/html; charset=utf-8;', 'Cache-Control' => 'public, max-age=86400' }, [@body]]
    end
  end
end
