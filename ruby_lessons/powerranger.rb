class Person 
	
	def initialize(name)
		@name = name
		@caffeine_level = 0
		puts "#{@name} is a new person."
	end

	def run(number_of_miles)
		number_of_miles.times do |x|
			puts "Run! Run! Run! Mile number #{x+1}"
			x += 1
		end
	end

	def scream(exclamation = "DUDE!", *more_exclamations)
		puts "AAAAAAHHHHHH!   OOOOOHHHHHHH!   #{exclamation}"
		more_exclamations.each {|x| puts "WOOOOAAAHH! #{x}"}
	end


end

class PowerRanger
end

class EvilNinja
end


#TEST CODE

bobby = Person.new("Robert")
bobby.scream("Oh Shit!", "MAN!", "Let's Go!")
bobby.run(12)
bobby.scream()
