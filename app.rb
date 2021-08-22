require 'sinatra'
require 'sinatra/reloader'

get '/hello/:name' do |name|
  "hello #{name}"
end

get '/goodbye' do 
  "good bye #{params[:name]}"
end

get '/erb_template_page' do
  erb :erb_template_page
end