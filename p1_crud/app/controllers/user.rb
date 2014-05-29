get '/' do
  erb :index
end

get '/user/new' do
  erb :"user/new"
end

post '/user' do
  @user = User.new(params[:user])

  if @user.save
    session[:messages] = ["Please Sign In"]
    redirect "/"
  else
    redirect "/user/new"
  end
end

post '/authenticate' do
  p params[:user]
  @user = User.authenticate(params[:username], params[:password])
  p @user
  if @user
    session[:user_id] = @user.id
    redirect "/profile"
  else
    session[:messages] = ["Login Failed"]
    redirect "/"
  end

end

get '/profile' do
  if current_user
    @user = User.find(session[:user_id])

    @errors = session[:errors]
    session[:errors] = nil
    erb :"user/profile"
  else
    redirect "/"
  end
end

get '/logout' do
  session[:user_id] = nil
  session[:messages] = ["You are now logged out."]
  redirect "/"
end
