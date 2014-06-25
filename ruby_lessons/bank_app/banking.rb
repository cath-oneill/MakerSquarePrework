class Customer
	attr_reader :name

	def initialize (name, cash)
		@name = name
		@cash = cash
	end
end

class Bank
	attr_reader :name_of_bank

	def initialize(name_of_bank)
		@name_of_bank = name_of_bank
	end

	def to_s
		"#{name_of_bank.upcase} HAS #{self.accounts_at_bank.size} ACCOUNTS."
	end

	def accounts_at_bank
		accounts_at_bank = Account.account_list.select{|x| x.bank==self}
	end

	def print_accounts_at_bank
		bank_accounts = self.accounts_at_bank
		puts self
		puts "----"
		bank_accounts.each {|x| puts x}
	end
end

class Account
	attr_reader :customer, :balance, :bank
	@@account_list = []

	def initialize(customer, bank, starting_balance)
		@customer = customer
		@balance = starting_balance
		@bank = bank
		@@account_list << self
		@account_number = @@account_list.find_index(self) + 1
	end

	def self.account_list
		@@account_list
	end

	def self.print_all_accounts
		puts "TOTAL ACCOUNTS AT ALL BANKS: #{@@account_list.size}"
		puts "----"
		@@account_list.each{|x| puts x}
	end

	def deposit(amount)
		@balance += amount
		puts "Deposit $#{amount} into account number #{@account_number}\n----"
	end

	def withdraw(amount)
		@balance -= amount
		puts "Withdraw $#{amount} from account number #{@account_number}\n----"
	end

	def to_s
		"Account Number: #{@account_number}\nCustomer: #{@customer.name}\nCurrent Balance: #{@balance}\nBank: #{@bank.name_of_bank}\n-----"
	end

end


