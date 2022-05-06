#!/usr/bin/env ruby
# frozen_string_literal: true

# Id$ nonnax 2022-05-05 16:00:11 +0800
require 'rack'
require_relative 'router'
require_relative 'view'

module Basic
  def self.set(k, v)
    Router::set(k, v)
  end

  def self.routes(&block)
    instance_eval(&block)
  end

  class App
    class Response < Rack::Response; end

    attr :req, :env, :res

    def fetch(env, **opts)
      r = Router::fetch(env, **opts)
      @status = r.status
      params = req.params.transform_keys(&:to_sym)
      if respond_to?(r.method) && @status != 404
        send(r.method, r.name, r.status, params)
      else
        @body='Not Found'
      end
    end

    def erb(page, **opts)
      View::erb(page, **opts)
    end

    def call(env)
      @req  = Rack::Request.new(env)
      @env  = env
      @body = fetch(env)
      [@status, { 'Content-Type' => 'text/html; charset=utf-8;', 'Cache-Control' => 'public, max-age=86400' }, [@body]]
    end
  end
end
