#!/usr/bin/env ruby
# Id$ nonnax 2022-03-22 22:25:13 +0800
require 'rack'
require_relative 'lib/view'
require_relative 'lib/router'
require 'json'

def pj(o)
  s="<code class='item'>"
  s<<JSON.pretty_generate(o)
  s<<'</code>'
end
Route::ROUTES={
  '/': :index,
  '/home': :index
}

class App
  class Response<Rack::Response; end
  def call(env)
    name, status = Route.fetch(env, default: :index).values_at(:name, :status)
    response_body = View.render(pj(env), title:'viewer')
    [status, {}, [response_body]]
  end
end
