require_relative 'cookbook.rb'
require 'sinatra'


get '/' do
	"<h1>my heading</h1>"
	@french = Cookbook.new('french cuisine')
	@variable_name = @french.title
	erb :index
end

