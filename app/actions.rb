# Homepage (Root path)

helpers do
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def is_logged_in?
    current_user != nil
  end

  def is_admin?
    is_logged_in? && current_user.is_admin?
  end
end



before '/admin/*' do
  redirect '/' unless is_logged_in? && current_user.is_admin?
end

get '/' do
  if cookies["page_views"]
    cookies["page_views"] = cookies["page_views"].to_i + 1
  else
    cookies[:page_views] = 1
  end
  # @cats_counter = 1
  erb :index, locals: {cats_counter: 1}
end

get '/session' do
  # binding.pry
  erb :login
end

post '/session' do
  # binding.pry
  if user = User.find_by(email: params[:email])
    if user.password == params[:password]
      session[:user_id] = user.id
      flash[:notice] = "Welcome to the site #{user.name}!"
      redirect '/'
    else
      flash[:notice] = "Your password was incorrect"
      erb :login
    end
  else
    flash[:notice] = "Your login information was bunk!"
    erb :login
  end
  # if users[params[:username].to_sym] == params[:password]
  #   session[:user_id] = params[:username]
  #
  # else
  #   # redirect '/session'
  #   # TODO flash message
  #
  # end
end

delete '/session' do
  # binding.pry
  session.destroy
  flash[:notice] = "See you later!"
  redirect '/'
end


namespace '/secrets' do

  before do
    redirect '/' unless is_logged_in?
  end

  get '/' do
    if is_logged_in?
      erb :'secrets/index'
    else
      flash[:notice] = 'Go away!'
      redirect '/'
    end
  end

  get '/1' do
    erb :'secrets/index'
  end
end
