#!/usr/bin/env ruby
# Id$ nonnax 2022-03-22 22:25:13 +0800
require_relative 'lib/basic'

Basic.set do |x|
  x['/'] = '<h1> <%=@data%> </h1> '
  x['/home']= :index
end

class App < Basic::App
  def call(env)
    name, status = fetch(env, default: :index).values_at(:name, :status)
    response_body = render(name, title:'viewer')
    [status, {'Content-Type' => 'text/html', 'Cache-Control' => 'public, max-age=86400'}, [response_body]]
  end
end
