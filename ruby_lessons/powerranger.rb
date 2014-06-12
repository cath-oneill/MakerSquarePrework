class Person 
	
	def initialize(name)
		@name = name
		@caffeine_level = 10
		puts "#{@name} is a new person."
	end

	def run(number_of_miles)
		number_of_miles.times do |x|
			puts "#{@name} runs! Run! Run! Mile number #{x+1}"
			x += 1
			@caffeine_level -= 2
		end
		check_caffeine_level()
	end

	#because of default and splat user can enter none or many arguments
	def scream(exclamation = "DUDE!", *more_exclamations)
		print "#{@name} is screaming: AAAAAAHHHHHH!  OOOOOHHHHHHH! #{exclamation} "
		more_exclamations.each {|x| print "WOOOOAAAHH!  #{x} "}
		puts "WOAH!"
		@caffeine_level -= 1
		check_caffeine_level()
	end

	def drink_coffee(cups)
		@caffeine_level += cups*10
		puts "Mmmmm....coffee! Now, #{@name}'s caffeine level is at #{@caffeine_level}."
	end

	def check_caffeine_level()
		if @caffeine_level <= 0
			puts "#{@name}'s caffeine level is at 0!  Drink coffee now!"
		elsif @caffeine_level < 10
			puts "#{@name}'s caffeine level is at #{@caffeine_level}!  Drink coffee soon!"
		end
	end	

end

class PowerRanger
end

class EvilNinja
end


#TEST CODE

bobby = Person.new("Robert")
bobby.scream("Oh Shit!", "MAN!", "Let's Go!")
bobby.run(3)
bobby.scream()
bobby.drink_coffee(4)
