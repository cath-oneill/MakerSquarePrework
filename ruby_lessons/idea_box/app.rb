class IdeaBoxApp < Sinatra::Base
  not_found do
    erb :error
  end
  
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index
  end

end