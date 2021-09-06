require 'sinatra'
require 'tilt'
require 'erubis'
require 'sinatra/reloader'

get "/" do
  redirect "/home"
  erb :home
end

get "/home" do
  erb :home
end

get "/depression/new" do
  erb :depression
end

get "/anxiety/new" do
  [200, "\n\n\n\n nothing here yet"]
end

post "anxiety/new" do
  "nothing here yet"
end

post "depression/new" do
  
end

get "/depression/reports" do
  
end

get "depressions/reports" do
  
end