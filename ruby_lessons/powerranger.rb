class Person 
	attr_reader :name
	
	def initialize(name)
		@name = name
		@caffeine_level = 10
		puts "#{@name} is a new person." unless self.is_a?(PowerRanger)
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

class PowerRanger < Person
	def initialize(name, strength, color)
		super name
		@strength = strength
		@color = color
		puts "#{@name} is a #{@color} Power Ranger." 
	end

	def punch(punchee)
		puts "POW! #{@name} punched #{punchee.name}."
 		@caffeine_level -= rand(@strength)*2 
		check_caffeine_level()
		punchee.scream("OUCH!")
		punchee.run(@strength-2)
	end

	def megazord(punchee)
		puts "POW! POW! POW! POW! POW! POW! POW! #{@name} brought MegaZord down onto #{punchee}!"
		@caffeine_level -= rand(@strength)*10
		check_caffeine_level
		punchee.scream("Ouch!", "OH!", "Waaaahhh! I want my mommy.", "Please help me!")
		punchee.run(@strength)
	end

	def rest(hours)
		@caffeine_level += rand(hours)
		check_caffeine_level
	end
end

class EvilNinja
end


#TEST CODE

bobby = Person.new("Robert")
bobby.scream("Oh Shit!", "MAN!", "Let's Go!")
bobby.run(3)
bobby.scream()
bobby.drink_coffee(4)

red = PowerRanger.new("Fred", 4, "red")
red.run(2)
red.punch(bobby)
red.drink_coffee(4)
bobby.drink_coffee(8)
red.megazord(bobby)
red.rest(2)

