require 'sinatra'
require 'tilt'
require 'erubis'
require 'sinatra/reloader'
require 'pry'
require_relative 'db_tools'

helpers do
  def interpert_depression(score)
    score = score.to_i
    case 
    when (0..4).include?(score) then "No Depression"
    when (5..10).include?(score) then "Boderline Depression"
    when (11..20).include?(score) then "Mild Depression"
    when (21..30).include?(score) then "Moderate Depression"
    when (31..45).include?(score) then "Severe Depression"
    else "Something went wrong."
    end
  end
end

before do
  @connect = PgInterface.new
end

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
  erb :anxiety
end

post "/anxiety/new" do
  @score = params.values.map(&:to_i).sum
  redirect "/home"
end

post "/depression/new" do
  @score = params.values.map(&:to_i).sum
  redirect "/home"
end

get "/depression/reports" do
  @user_id = 1
  @scores = @connect.depression_scores(@user_id)
  erb :depression_report
end

get "depressions/reports" do
  
end

after do
  @connect.close
end