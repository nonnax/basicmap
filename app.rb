#!/usr/bin/env ruby
# Id$ nonnax 2022-03-22 22:25:13 +0800
require 'rack'
require_relative 'lib/view'
require_relative 'lib/router'

class App
  def call(env)
    route = Route.new(env).route_name
    status = (route.match(/^\d+$/) || "200").to_s
    response_body = View.new(route, visit_count: parse_session_count_cookie(env)).render

    [status, {}, [response_body]]
  end

  def parse_session_count_cookie(env)
    Rack::Utils.parse_cookies(env)["session_count"]
  end
end
