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

	def print_cookbook
		puts "------------------"
		puts "------------------"
		puts @title.upcase
		puts "------------------"
		@recipes.each do |x| 
			x.print_recipe
			puts "------------------"
		end
		puts "End of cookbook.  #{@recipes.length} recipes printed."
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
		while x < steps.length do #look at each with index
			x +=1
			puts "#{x}. #{@steps[x-1].capitalize}."
		end		
	end

end
#end of Recipe class

class Menu

	def initialize(date)
		@date = date
		@menu_array = []
	end

	attr_accessor :date
	attr_accessor :menu_array

	def add_recipe_to_menu(*menu_recipes)
		menu_recipes.each {|menu_recipes| @menu_array << menu_recipes}
		puts "The menu for #{@date} includes #{@menu_array.length} recipes:"
		@menu_array.each {|y| puts y.title}
	end

	def shopping_list
		puts "The shopping list for #{@date} includes:"
		@menu_array.each do |x| 
			ingredients_array = x.ingredients
			ingredients_array.each {|y| puts "-- #{y}"}
		end
	end
end

