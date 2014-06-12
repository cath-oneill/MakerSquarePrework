class Person 
	attr_reader :name
	attr_writer :caffeine_level

	def initialize(name)
		@name = name
		@caffeine_level = 10
		puts "#{@name} is a new person." unless self.is_a?(PowerRanger)
	end

	def run(number_of_miles = 2)
		if sufficient_caffeine_level(2)
			number_of_miles.times do |x|
				puts "#{@name} runs! Run! Run! Mile number #{x+1}"
				x += 1
				@caffeine_level -= 2
			end
			check_caffeine_level()
		else
			puts "#{@name} doesn't have enough caffeine to run.  Drink coffee now!"
		end
	end

	#because of default and splat user can enter none or many arguments
	def scream(exclamation = "DUDE!", *more_exclamations)
		if sufficient_caffeine_level(1)
			print "#{@name} is screaming: AAAAAAHHHHHH!  OOOOOHHHHHHH! #{exclamation} "
			more_exclamations.each {|x| print "WOOOOAAAHH!  #{x} "}
			puts "WOAH!"
			@caffeine_level -= 1
			check_caffeine_level()
		else
			puts "#{@name} doesn't have enough caffeine to scream.  Drink coffee now!"
		end
	end

	def drink_coffee(cups = 1)
		@caffeine_level += cups*10
		puts "Mmmmm....coffee! Now, #{@name}'s caffeine level is at #{@caffeine_level}."
	end

	#used to print at end of msgs if caffeine is low
	def check_caffeine_level()
		if @caffeine_level <= 0
			puts "#{@name}'s caffeine level is at 0!  Drink coffee now!"
		elsif @caffeine_level < 10
			puts "#{@name}'s caffeine level is at #{@caffeine_level}!  Drink coffee soon!"
		end
	end	

	#use to check for enough caffeine at the beginning of methods with if statement
	def sufficient_caffeine_level(min)
		@caffeine_level >= min
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
		if sufficient_caffeine_level(@strength)
			puts "POW! #{@name} punched #{punchee.name}."
	 		@caffeine_level -= rand(@strength)*2 
			check_caffeine_level()
			punchee.scream("OUCH!")
			punchee.run(@strength-2)
		else
			puts "#{@name} doesn't have enough caffeine to punch.  Drink coffee now!"
		end
	end

	def megazord(punchee)
		if sufficient_caffeine_level(@strength*5)
			puts "POW! POW! POW! POW! POW! POW! POW! #{@name} brought MegaZord down onto #{punchee}!"
			@caffeine_level -= rand(@strength)*10
			check_caffeine_level
			punchee.scream("Ouch!", "OH!", "Waaaahhh! I want my mommy.", "Please help me!")
			punchee.run(@strength)
		else
			puts "#{@name} doesn't have enough caffeine for a MegaZord.  Drink coffee now!"
		end
	end

	def rest(hours = 1)
		@caffeine_level += rand(hours)
		check_caffeine_level
	end
end

class EvilNinja < Person
	def initialize(name, strength, evilness)
		super name
		@strength = strength
		@evilness = evilness
		puts "#{@name} is a level-#{@evilness} Evil Ninja."
	end

	def punch(punchee)
		if sufficient_caffeine_level(@strength)
			puts "POW! #{@name} punched #{punchee.name}."
	 		@caffeine_level -= rand(@strength)*2 
			check_caffeine_level()
			punchee.scream("OUCH!")
			punchee.run(@strength-2)
		else
			puts "#{@name} doesn't have enough caffeine to punch.  Drink coffee now!"
		end
	end

	def cause_mayhem(victim)
		if @evilness > 0 && sufficient_caffeine_level(10)
			victim.caffeine_level = 0
			@evilness -= 1
			@caffeine_level -= 8 + rand(@strength)
			puts "MAYHEM! #{@name} stole #{victim.name}'s caffeine!"
			victim.scream("OOOOOOHHHH NOOOOOO!", "I feel so tired.", "BITCHY! BITCHY! BITCHY!")
			check_caffeine_level()
		else
			puts "No mayhem occurred because #{@name} is running out of steam."
			puts "Evilness: #{@evilness}"
			puts "Caffeine level: #{@caffeine_level}"
		end
	end

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

knievel = EvilNinja.new("Evel", 8, 3)
p bobby
p red
p knievel
knievel.cause_mayhem(red)
p bobby
p red
p knievel
knievel.cause_mayhem(bobby)
knievel.drink_coffee(3)
knievel.punch(bobby)
p bobby
bobby.run(12)
p bobby
p knievel
knievel.cause_mayhem(bobby)
bobby.run



