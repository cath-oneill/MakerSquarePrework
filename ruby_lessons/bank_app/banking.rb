class Customer
	attr_reader :name
	attr_accessor :cash

	def initialize (name, cash)
		@name = name
		@cash = cash
		puts "NEW CUSTOMER: #{self}\n----"
	end

	def to_s
		"#{@name} has $#{@cash} in cash."
	end
end

class Bank
	attr_reader :name_of_bank

	def initialize(name_of_bank)
		@name_of_bank = name_of_bank
		puts "NEW BANK: #{@name_of_bank}\n----"
	end

	def to_s
		"#{name_of_bank.upcase} HAS #{self.accounts_at_bank.size} ACCOUNTS.\n----"
	end

	def accounts_at_bank
		accounts_at_bank = Account.account_list.select{|x| x.bank==self}
	end

	def print_accounts_at_bank
		bank_accounts = self.accounts_at_bank
		puts self
		bank_accounts.each {|x| puts x}
	end
end

class Account
	attr_reader :customer, :balance, :bank
	@@account_list = []

	def initialize(customer, bank, starting_balance)
		@customer = customer
		@balance = 0
		@bank = bank
		@@account_list << self
		@account_number = @@account_list.find_index(self) + 1
		puts "NEW ACCOUNT: Account Number #{@account_number}"
		self.deposit(customer, starting_balance)
		puts self
	end

	def self.account_list
		@@account_list
	end

	def self.print_all_accounts
		puts "TOTAL ACCOUNTS AT ALL BANKS: #{@@account_list.size}\n----"
		@@account_list.each{|x| puts x}
	end

	def deposit(customer, amount)
		@balance += amount
		customer.cash -= amount
		puts "#{customer.name} deposited $#{amount} into account number #{@account_number} at #{@bank.name_of_bank}.\n#{customer.to_s}\n#{self}"
	end

	def withdraw(customer, amount)
		if self.insufficient_balance(amount) 
			puts "There are insufficient funds for this withdrawal!  Transaction cancelled!"
			puts self
			return nil
		end
		@balance -= amount
		customer.cash += amount
		puts "#{customer.name} withdrew $#{amount} from account number #{@account_number} at #{@bank.name_of_bank}.\n#{customer.to_s}\n#{self}"
	end

	def self.transfer(customer, from_acct, to_acct, amount)
		puts "TRANSFER"
		from_acct.withdraw(customer, amount)
		to_acct.deposit(customer, amount)
	end

	def to_s
		"Account Number: #{@account_number}\nCustomer: #{@customer.name}\nCurrent Balance: #{@balance}\nBank: #{@bank.name_of_bank}\n-----"
	end

	def insufficient_balance(minimum)
		self.balance < minimum 
	end



end


