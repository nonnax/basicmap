#!/usr/bin/env ruby
# Id$ nonnax 2022-03-22 22:25:13 +0800
require 'rack'
require_relative 'lib/view'
require_relative 'lib/router'
require 'json'

Route.set do |x|
  x['/'] = '<h1> <%=@data%> </h1> '
  x['/home']= :index
end

class App
  class Response<Rack::Response; end
  def call(env)
    name, status = Route.fetch(env, default: :index).values_at(:name, :status)
    response_body = View.render(name, title:'viewer')
    [status, {'Content-Type' => 'text/html', 'Cache-Control' => 'public, max-age=86400'}, [response_body]]
  end
end
