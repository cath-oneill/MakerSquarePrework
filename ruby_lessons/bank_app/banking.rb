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

	def current_funds
		funds = self.accounts_at_bank.map{|x| x.balance}.inject(:+)
		puts "CURRENT FUNDS: #{self.name_of_bank} has $#{funds} on hand.\n----"
	end
end

class Account
	attr_reader :customer, :balance, :bank
	@@account_list = []

	def initialize(customer, bank, starting_balance)
		@customer = customer
		@balance = 0
		@bank = bank
		def not_for_child_class(customer, starting_balance)
			@@account_list << self
			@account_number = @@account_list.find_index(self) + 1
			puts "NEW ACCOUNT:"
			self.deposit(customer, starting_balance)
		end
		self.not_for_child_class(customer, starting_balance) unless self.is_a? CreditCard
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
		puts "#{customer.name} deposited $#{amount} into account number #{@account_number} at #{@bank.name_of_bank}.\n#{customer}\n#{self}"
	end

	def withdraw(customer, amount)
		return nil if self.cancel_if_insufficient_funds(amount)
		@balance -= amount
		puts "#{customer.name} withdrew $#{amount} from account number #{@account_number} at #{@bank.name_of_bank}."
		unless self.is_a? CreditCard
			customer.cash += amount 
			puts customer
		end
		puts self
	end

	def self.transfer(customer, from_acct, to_acct, amount)
		puts "TRANSFER"
		from_acct.withdraw(customer, amount)
		to_acct.deposit(customer, amount)
	end

	def to_s
		"Account Number: #{@account_number}\nCustomer: #{@customer.name}\nCurrent Balance: #{@balance}\nBank: #{@bank.name_of_bank}\n-----"
	end

	def cancel_if_insufficient_funds(amount)
		if self.is_a? CreditCard
			if (@balance - amount) < @credit_limit
				puts "There are insufficient funds for this purchase!  Transaction cancelled!"
				puts self
				return true
			end
		else
			if @balance < amount
				puts "There are insufficient funds for this withdrawal!  Transaction cancelled!"
				puts self
				return true
			end
		end
	end
end

class CreditCard < Account
	@@creditcard_list = []

	def initialize(customer, bank, credit_limit)
		@credit_limit = credit_limit * -1
		@@creditcard_list << self
		@account_number = "CC" + (@@creditcard_list.find_index(self) + 1).to_s
		super
		puts "NEW CREDIT ACCOUNT:\n#{self}"
	end

	def to_s
		"Credit Card Account Number: #{@account_number}\nCredit Limit: #{@credit_limit}\nCustomer: #{@customer.name}\nCurrent Balance: #{@balance}\nBank: #{@bank.name_of_bank}\n-----"
	end

	def make_purchase(price)
		puts "CREDIT CARD PURCHASE FOR $#{price}"
		self.withdraw(self.customer, price)
	end

	def make_payment(amount)
		puts "CREDIT CARD PAYMENT FOR $#{amount}"
		self.deposit(self.customer, amount)
	end
end


