class Cookbook

	def initialize(title)
		@title = title
		@recipes = []
	end 

	attr_accessor :title
	attr_reader :recipes

	def add_recipe(recipe)
		@recipes << recipe
		puts "Added a recipe to the collection: #{recipe.title}"
	end

	def recipe_titles
		@recipes.each {|entry| puts entry.title}
	end

	def recipe_ingredients
		@recipes.each { |entry| puts "These are the ingredients for #{entry.title}: #{entry.ingredients}."}
	end

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

	def print_recipe
		puts "Recipe Details: #{@title}"
		puts "Ingredients"
		@ingredients.each {|x| puts "-- #{x}"}
		puts "Instructions"
		x = 0
		while x < steps.length do 
			x +=1
			puts "#{x}. #{@steps[x-1].capitalize}."
		end		
	end

end
#end of Recipe class
