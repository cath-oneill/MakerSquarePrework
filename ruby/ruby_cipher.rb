#Encryptor project based on tutorial:  http://tutorials.jumpstartlab.com/projects/encryptor.html

class Encryptor

	def cipher(rotation)
		input_array = (' '..'z').to_a
		output_array = input_array.rotate(rotation)
		look_up_table = input_array.zip(output_array)
		Hash[look_up_table]
	end

	def encrypt_character(char, rotation)
		cipher_to_use = cipher(rotation)
		cipher_to_use[char]
	end

	def encrypt(string, rotation = 13)
		input_text = string.split("")
		
		output_text = input_text.collect do |x|
			encrypt_character(x, rotation)
		end

		output_text.join
	end

##Decryption


	def decrypt(string, rotation = 13)
		encoded_text = string.split("")
		neg_rotation = rotation * -1
		decoded_text = encoded_text.collect do |x|
			encrypt_character(x, neg_rotation)
		end

		decoded_text.join
	end
end #end Encryptor class



## TO USE:
## 1. Start command prompt, get to correct directory
## 2. Then Start IRB
## 3. Then -- load 'RubyCipher.rb'
## 4. Create an instance of the class
## 5. Use methods as necessary...