#!/usr/bin/env ruby
# Id$ nonnax 2022-03-22 22:25:13 +0800
require 'rack'
require_relative '../lib/basic'
require_relative 'lib/model'

Basic.routes do
  set '/',      :index
  set '/show',  :show
  set '/about',  '<%=data[:title]%>'
end

# Basic.views do
  # set :layout, 'lay'
# end

DB::load

class App < Basic::App
  def db
    DB::data
  end

  def get name, params
    doc = db[params[:item].to_i]
    erb name, title: doc[:tag], db:, doc:, params:
  end

  def default
    erb 'Not Found'
  end
end
