class Car
	@@total_car_count = 0
	@@cars_per_color = {}

	def self.total_car_count
		@@total_car_count
	end

	def self.cars_per_color
		@@cars_per_color
	end

	def initialize(color)
		@fuel = 10
		@distance = 0
		
		#increase total_car_count each time a new car is initialized
		@@total_car_count += 1
		
		#allows user to insert string or symbol
		#if a string is put in for the color, it will be converted to a string
		if color.is_a? String
			color_as_symbol = color.to_sym
		else 
			color_as_symbol = color
		end
		@color = color_as_symbol

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
end

car_a = Car.new("blue")
car_b = Car.new(:red)
puts car_a
puts car_b
car_a.drive(10)
puts car_a
puts car_b
car_a.drive(232)
car_b.drive(117)
puts car_a
puts car_b

puts Car.total_car_count
c1 = Car.new(:green)
puts Car.total_car_count
c2 = Car.new(:blue)
puts Car.total_car_count

p Car.cars_per_color