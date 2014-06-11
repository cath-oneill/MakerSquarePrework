class Cookbook

	def initialize(title)
		@title = title
	end 

	attr_accessor :title

end
#end of Cookbook class


class Recipe

	def initialize(title, ingredients, steps)
		@title = title
		@ingredients = ingredients
		@steps = steps
	end

	attr_accessor :title
	attr_accessor :ingredients
	attr_accessor :steps


end
#end of Recipe class
