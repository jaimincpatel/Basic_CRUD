get '/notes' do  # Show all
  if current_user
    @user = User.find(session[:user_id])
    erb :notes
  else
    redirect '/'
  end
end

get '/notes/new' do  # Step1.) Create
  if current_user
    erb :"notes/new"
  else
    redirect '/'
  end
end

post '/notes' do  # Step2.) Create
  @user = User.find(session[:user_id])
  @note = Note.create(title: params[:title], body: params[:body], user_id: @user.id)
  redirect '/notes'
end

get '/notes/:id' do  # Show specific
  if current_user
    @user = User.find(session[:user_id])
    @note = Note.find(params[:id])
    erb :"notes/view_note"
  else
    redirect '/'
  end
end

# get '/notes/:id/edit' do  # Step1.) Edit
# end

put '/notes/:id' do  # Step2.) Edit
  if current_user
    @note = Note.find(params[:id])
    @note.update_attributes(title: params[:title], body: params[:body])
    redirect '/notes'
  else
    redirect '/'
  end

end

delete '/notes/:id' do  # Delete
  if current_user
    @note = Note.find(params[:id])
    @note.destroy
    redirect '/notes'
  else
    redirect '/'
  end
end
