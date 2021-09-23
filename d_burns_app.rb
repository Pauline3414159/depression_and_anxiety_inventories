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

  def interpert_anxiety(score)
    score = score.to_i
    case 
    when (0..4).include?(score) then "No Anxiety"
    when (5..10).include?(score) then "Boderline Anxiety"
    when (11..20).include?(score) then "Mild Anxiety"
    when (21..30).include?(score) then "Moderate Anxiety"
    when (31..50).include?(score) then "Severe Anxiety"
    when (51 .. 99).include?(score) then "Extreme Anxiety"
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
  @user_id = 1
  @score = params.values.map(&:to_i).sum
  @connect.add_anxiety_score(@user_id, @score)
  redirect "/home"
end

post "/depression/new" do
  @user_id = 1
  @score = params.values.map(&:to_i).sum
  @connect.add_depression_score(@user_id, @score)
  redirect "/home"
end

get "/depression/reports" do
  @user_id = 1
  @scores = @connect.depression_scores(@user_id)
  erb :depression_report
end

get "/anxiety/reports" do
  @user_id = 1
  @scores = @connect.anxieties_scores(@user_id)
  erb :anxiety_report
end

after do
  @connect.close
end