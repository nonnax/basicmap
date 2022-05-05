#!/usr/bin/env ruby
# Id$ nonnax 2022-03-22 22:25:13 +0800
require 'rack'
require_relative 'lib/basic'

def load
  db=[]
  Dir.chdir 'public/models' do
      Dir['*'].each do |f|
         db << eval(IO.popen(["yaml", f], &:read))
      end
  end
  db
end

Basic.routes do
  @database = load
  set '/',  @database.map.with_index{|h, i|
              h.transform_keys(&:to_sym)=>{tag:, body:}
              %( <div class="item">
                <h1><a href='/show?item=#{i}'>#{tag}</a></h1>
                <p>"#{body[0]}"</p></div> )
            }.join

  set '/home',  :index

  set '/show',  :show

end

class App < Basic::App
  def get
    db = load
    name, @status = fetch(env, default: :index).values_at(:name, :status)

    erb name, title:'File item', doc: db[req.params['item'].to_i], params: req.params
  end
end
