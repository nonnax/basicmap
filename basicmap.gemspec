
Gem::Specification.new do |s|
  s.name = 'basicmap'
  s.version = '0.0.1'
  s.date = '2022-05-08'
  s.summary = "a basic rack mapper"
  s.authors = ["xxanon"]
  s.email = "ironald@gmail.com"
  s.files = `git ls-files`.split("\n") - %w[bin misc]
  s.executables += `git ls-files bin`.split("\n").map{|e| File.basename(e)}
  s.homepage = "https://github.com/nonnax/heroku_basic.git"
  s.license = "GPL-3.0"
end

---------cut-----------
# Gemfile

source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# gem 'heroku_basic', :github => 'nonnax/heroku_basic'
