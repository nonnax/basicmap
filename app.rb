#!/usr/bin/env ruby
# Id$ nonnax 2022-03-22 22:25:13 +0800
require 'rack'
require_relative 'lib/basic'

DOC=<<~___
VERA FILES FACT CHECK: Columnist Tundag falsely claims Marcos Jr. ‘accepted’ dismissal of 2016 election protest
By VERA FILES
Apr 27, 2022 6:18 PM

Columnist Jerry Suico Tundag of Cebu-based newspaper The Freeman falsely claimed in a tweet that presidential candidate Ferdinand “Bongbong” Marcos Jr.  had “accepted” the verdict of the Presidential Electoral Tribunal (PET), which dismissed in its entirety his poll protest against Vice President Leni Robredo six years ago.
___

Basic.routes do

  set '/',  (1..20).inject(''){|acc, s|
              acc<< %(<div class="item">
                  <h1><a href='/show?item=#{s}'><%=@data[:title]%></a></h1>
                  <p><%=@data[:doc][0..120]%></p></div>)
                  }

  set '/home',  :index

  set '/show',  :show

end

class App < Basic::App
  def get
    name, @status = fetch(env, default: :index).values_at(:name, :status)
    erb name, title:'File item', doc: DOC, params: req.params
  end
end
