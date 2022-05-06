#!/usr/bin/env ruby

# Id$ nonnax 2022-03-01 15:28:55 +0800
class Router

  ROUTES = { '/' => 'Welcome!' }

  def self.fetch(env, default: nil)
    status = 200
    name=ROUTES[env['PATH_INFO']]
    result = name ? { name:, status:} : { name: default, status: 404}
    request_method = env['REQUEST_METHOD'].downcase
    [request_method, result]
  end
end
