#!/usr/bin/env ruby
# Id$ nonnax 2022-03-22 22:25:13 +0800
require 'rack'
require_relative 'lib/basic'
require_relative 'lib/model'

Basic.routes do
  set '/',      :index
  set '/show',  :show
  set '/about',  '<%=data[:title]%>'
end

class App < Basic::App
  def db
    DB::load
  end
  def get(name, status, params)
    @status = status
    doc = db[params[:item].to_i]
    erb name, title: doc[:tag], db:, doc:, params: 
  end
end
