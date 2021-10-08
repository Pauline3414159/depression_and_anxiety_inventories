require 'sinatra'
require 'tilt'
require 'erubis'
require_relative 'db_tools'

configure.assets.initialize_on_precompile = false


helpers do
  def interpert_depression(score)
    score = score.to_i
    case score
    when (0..4) then 'No Depression'
    when (5..10) then 'Boderline Depression'
    when (11..20) then 'Mild Depression'
    when (21..30) then 'Moderate Depression'
    when (31..45) then 'Severe Depression'
    else 'Something went wrong.'
    end
  end

  def interpert_anxiety(score)
    score = score.to_i
    case score
    when (0..4) then 'No Anxiety'
    when (5..10) then 'Boderline Anxiety'
    when (11..20) then 'Mild Anxiety'
    when (21..30) then 'Moderate Anxiety'
    when (31..50) then 'Severe Anxiety'
    when (51..99) then 'Extreme Anxiety'
    else 'Something went wrong.'
    end
  end
end
configure do
  enable :sessions
  set :session_secret, "e5a44ff4292412d123b548648b"
end


before do
  @connect = PgInterface.new
  @message = session.delete('msg')
  @user_id_num = session['user_id_num']
  @username = session['username']
end

get '/signup' do
  erb :sign_up
end

get '/signin' do
  erb :sign_in
end

get '/delete/account' do
  erb :confirm_delete
end

post '/delete/account' do
  @connect.delete_user(@user_id_num)
  session.delete('user_id_num')
  session.delete('username')
  redirect '/home'
end

post '/signin' do
  @connect.sign_in(params['email'], params['password'])
  if !!@connect.user_id_num
    session['user_id_num'] = @connect.user_id_num
    session['username'] = params['email']
    redirect '/home'
  else
    session['msg'] = 'Invalid Email or Password'
    redirect '/signin'
  end
end

get '/signout' do
  session.delete('user_id_num')
  session.delete('username')
  redirect '/home'
end

post '/signup' do
  @user_mail = params['email']
  @password = params['password']
  @connect.add_user(@user_mail, @password)
  if @connect.message
    session['msg'] = @connect.message.dup
    @connect.message = nil
    redirect '/signup'
  else
    redirect '/home'
  end
end

get '/' do
  redirect '/home'
  erb :home
end

get '/home' do
  erb :home
end

get '/depression/new' do
  erb :depression
end

get '/anxiety/new' do
  erb :anxiety
end

post '/anxiety/new' do
  @score = params.values.map(&:to_i).sum
  @connect.add_anxiety_score(@user_id_num, @score)
  redirect '/home'
end

post '/depression/new' do
  @score = params.values.map(&:to_i).sum
  if params['Do you have a plan for harming yoursel'] != '0' ||
     params['Would you like to end your life?'] != '0' ||
     params['Do you have any suicidal thoughts?'] != '0'
    session['msg'] =
      'Contact <a href="https://suicidepreventionlifeline.org/" target="_blank"> the suicide prevention lifeline for help! </a>'
  end
  @connect.add_depression_score(@user_id_num, @score)
  redirect '/home'
end

get '/depression/reports' do
  @scores = @connect.depression_scores(@user_id_num)
  erb :depression_report
end

get '/anxiety/reports' do
  @scores = @connect.anxieties_scores(@user_id_num)
  erb :anxiety_report
end

after do
  @connect.close
end
