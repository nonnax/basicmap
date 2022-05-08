#!/usr/bin/env ruby
# Id$ nonnax 2022-05-06 01:21:15 +0800
require 'yaml'
require 'kramdown'

module DB
  def self.to_html(doc)
    Kramdown::Document.new(doc).to_html
  end

  def self.data
    @data
  end

  def self.to_hash(doc, &block)
    header, body = doc.split(/-{3,}/,2)
    header = YAML.load(header)
    body = block.call(body) if block
    header.tap{|h| h['body'] = [to_html(body)] }
    header.transform_keys(&:to_sym)
  end

  def self.load(&block)
    @data=[].tap{|d|
      Dir['public/models/*'].each do |f|
         d << to_hash(File.read(f), &block)
      end
    }
  end
end
