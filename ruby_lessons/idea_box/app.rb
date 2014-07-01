require './idea'


class IdeaBoxApp < Sinatra::Base
	not_found do
		erb :error
	end

	configure :development do
		register Sinatra::Reloader
	end

	post '/' do
		idea = Idea.new
		idea.save
		"Creating an idea!"
	end

	get '/' do
    	erb :index
	end

end