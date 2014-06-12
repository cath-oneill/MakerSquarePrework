class Person 
	attr_reader :name
	attr_accessor :caffeine_level
	@@person_array = []

	def initialize(name)
		@name = name
		@caffeine_level = 10
		@@person_array << self
		puts "#{@name} is a new person." unless self.is_a?(PowerRanger) || self.is_a?(EvilNinja)
	end

	def self.person_array
		@@person_array
	end

	def run(number_of_miles = 1+rand(3))
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

	def punch(punchee = Person.person_array.sample)
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

	def megazord(punchee = Person.person_array.sample)
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

	def punch(punchee = Person.person_array.sample)
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

	def cause_mayhem(victim = Person.person_array.sample)
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

def go_to_coffee_shop()
	Person.person_array.each {|x| x.drink_coffee(3 + rand(5))}
end

current_fighter = 
current_victim = 

def fight()
	go_to_coffee_shop()
	number_of_turns = rand(10 + rand(20))
	puts "There are #{number_of_turns} rounds in this fight!"
	number_of_turns.times do |x|
		puts "Round #{x+1}, FIGHT!"
		current_fighter = Person.person_array.sample
		
		if current_fighter.is_a?(PowerRanger)
			current_fighter.run()
		else
			random_roll = rand(2)
			current_fighter.run() if random_roll==0
			current_fighter.scream() if random_roll==1
		end
	end
end



#TEST CODE
p Person.person_array
bobby = Person.new("Robert")
# red = PowerRanger.new("Fred", 4, "red")
# knievel = EvilNinja.new("Evel", 8, 3)
p Person.person_array


p Person.person_array

fight()




