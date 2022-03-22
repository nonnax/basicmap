#!/usr/bin/env ruby
# Id$ nonnax 2022-03-01 15:28:55 +0800
class Route
  ROUTES = {
    "/" => :index
  }

  def initialize(env)
    if env["REQUEST_METHOD"] == "GET"
      @route_name = ROUTES[env["PATH_INFO"]]
    end
  end

  def route_name
    (@route_name || "404").to_s
  end
end
