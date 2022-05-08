#!/usr/bin/env ruby

# Id$ nonnax 2022-03-01 15:28:55 +0800
class Router

  ROUTES = { '/' => 'Welcome!' }
  def self.set(k, v)
    ROUTES[k]=v
  end
  def self.fetch(env, default: nil)
    status = 200
    name = ROUTES[env['PATH_INFO']]
    result = name ? { name:, status:} : { name: default, status: 404}
    result.merge!(method: env['REQUEST_METHOD'].downcase)
    Struct.new(*result.keys).new(*result.values)
  end
end
