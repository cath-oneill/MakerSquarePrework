class Car
	@@total_car_count = 0
	@@cars_per_color = {}

	def self.total_car_count
		@@total_car_count
	end

	def self.cars_per_color
		@@cars_per_color
	end

	def initialize(color = :unknown)
		@fuel = 10
		@distance = 0
		@color = color

		#increase total_car_count each time a new car is initialized
		@@total_car_count += 1
		
		#allows user to insert string or symbol
		#if a string is put in for the color, it will be converted to a symbol
		color_into_hash(color.to_sym)
	end

	def color_into_hash(color_as_symbol)
			#put info about color into hash
		if @@cars_per_color.has_key?(color_as_symbol)
			@@cars_per_color[color_as_symbol] += 1
		else 
			@@cars_per_color[color_as_symbol] = 1
		end
	end


	def to_s()
		"I'm a #{@color} car! I've driven #{@distance} and have #{@fuel} gallons gas left."
	end

	def drive(miles)
		if (@fuel - miles/20.0) >= 0
			@distance += miles
			@fuel -= miles/20.0
		else
			@distance += @fuel * 20.0
			@fuel = 0
			puts "You're out of gas!"
		end
	end

	def fuel_up()
		gallons_needed = 10.0 - @fuel
		puts "You must pay $#{3.5 * gallons_needed}"
		@fuel = 10.0
	end

	def color=(new_color)
		@@cars_per_color[@color] -= 1
		color_into_hash(new_color.to_sym)
	end

	def self.most_popular_color
		common_color_pair = @@cars_per_color.max_by {|key, value| value}
		common_color = common_color_pair[0]
		puts "The most popular color is #{common_color.to_s}."
		common_color
	end

end

class Convertible < Car
	def initialize(color = :unknown)
		super color
		@roof_status = :closed
	end

	attr_reader :roof_status

	def top_down
		@roof_status = :open
		puts "The roof is open!"
	end

	def close_top
		@roof_status = :closed
		puts "The roof is closed!"
	end

	def to_s()
		"I'm a convertible, and the roof is #{@roof_status.to_s}. " + super
	end
end


#TEST CODE
car_a = Car.new("blue")
car_b = Car.new(:red)
car_c = Car.new
puts car_a
puts car_b
car_a.drive(10)
puts car_a
puts car_b
car_a.drive(232)
car_b.drive(117)
puts car_a
puts car_b
puts car_c

puts Car.total_car_count
car_d = Car.new(:green)
puts Car.total_car_count
car_e = Car.new(:blue)
puts Car.total_car_count

p Car.cars_per_color
Car.most_popular_color #should be blue -- car_a and car_e are blue
car_e.color = ("green")
p Car.cars_per_color
Car.most_popular_color #should be green -- now car_d and car_e

best_color = Car.most_popular_color
car_f = Car.new(best_color)
puts car_f
p Car.cars_per_color #now 3 greens

puts "CONVERTIBLE TIME"
miata = Convertible.new("blue") #7th car!
miata.roof_status
miata.top_down
miata.roof_status
miata.close_top
miata.roof_status
puts miata 

p Car.cars_per_color #now 3 greens and 2 blues
Car.most_popular_color
puts Car.total_car_count #shoud be 7
