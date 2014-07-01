require 'sinatra'
require 'sinatra/reloader'

set :secret_number, rand(100) + 1
set :times_guessed, 0


def check_guess(number)
	number = number.to_i
	
	if number==0
		"Enter your best guess! Pick a number between 1 and 100.  You only have 5 turns to guess the correct number."
	elsif number == settings.secret_number 	
		settings.secret_number = rand(100) + 1
		settings.times_guessed = 0
		"You got it right! Are you ready to play again?  Go ahead and make your next guess!"
	elsif settings.times_guessed < 4
		if number > settings.secret_number + 20
			settings.times_guessed += 1
			"#{number} is WAY too high! You have guessed #{settings.times_guessed} times."
		elsif number < settings.secret_number - 20
			settings.times_guessed += 1
			"#{number} is WAY too low! You have guessed #{settings.times_guessed} times."
		elsif number > settings.secret_number
			settings.times_guessed += 1
			"#{number} is too high! You have guessed #{settings.times_guessed} times."
		elsif number < settings.secret_number
			settings.times_guessed += 1
			"#{number} is too low! You have guessed #{settings.times_guessed} times."
		end
	else			
		settings.secret_number = rand(100) + 1
		settings.times_guessed = 0
		"You lost! You've already guessed 5 times.  A new secret number has been set; try again."
	end		
end


get '/'  do 
	user_guess = params["guess"]
	message = check_guess(user_guess)
	erb :index, :locals => {:message => message}
end

