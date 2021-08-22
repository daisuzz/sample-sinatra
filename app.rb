require 'faraday'
require 'sinatra'
require 'json'
require 'sinatra/json'
require 'sinatra/reloader'

# change a base folder for static file
set public_folder: "#{__dir__}/static"

field_list = %w[userId id title body]

get '/' do
  redirect '/index.html'
end

get '/posts' do
  field = params.fetch(:field)

  unless field_list.include?(field)
    status 400
    body 'field not found!'
    return
  end

  posts = JSON.parse(Faraday.get('https://jsonplaceholder.typicode.com/posts').body)

  res = posts.map { |post| { "#{field}": post[field].to_s } }

  json res
end

get '/posts/:id' do
  Faraday.get("https://jsonplaceholder.typicode.com/posts/#{params[:id]}").body
end
