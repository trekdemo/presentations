require 'bundler'
Bundler.setup

require 'kramdown'
require 'haml'

task :default => :doc

desc 'Create html output from markdown'
task :doc do
  bootstrap    = '//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css'
  responsive   = '//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap-theme.min.css'
  style        = <<-EOF
  .container { max-width: 730px; }
  EOF
  readme       = <<-EOF
!!!
%html
  %head
    %meta{charset: 'utf8'}
    %title
    %link{href:"#{bootstrap}",  type:"text/css", rel:"stylesheet"}
    %link{href:"#{responsive}", type:"text/css", rel:"stylesheet"}
    %style
      =style
  %body
    %div.container
      =content
  EOF

  locals = {
    content: Kramdown::Document.new(File.read('README.md')).to_html,
    style: style
  }
  open('index.html', 'w') {|f| f.puts Haml::Engine.new(readme).to_html Object.new, locals}
end
