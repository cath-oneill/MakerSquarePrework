require 'idea_box'


class IdeaBoxApp < Sinatra::Base
	set :method_override, true
	set :root, 'lib/app'

	not_found do
		erb :error
	end

	configure :development do
		register Sinatra::Reloader
	end
	
	get '/' do
    	erb :index, locals: {ideas: IdeaStore.all, idea: Idea.new}
	end

	get '/:id/edit' do |id|
  		idea = IdeaStore.find(id.to_i)
  		erb :edit, locals: {id: id, idea: idea}
	end

	post '/' do
  		IdeaStore.create(params[:idea])
  		redirect '/'
	end

	delete '/:id' do |id|
		IdeaStore.delete(id.to_i)
		redirect '/'
	end

	put '/:id' do |id|
  		data = {
    		:title => params['idea_title'],
    		:description => params['idea_description']
  		}
  		IdeaStore.update(id.to_i, params[:idea])
  		redirect '/'
	end
end