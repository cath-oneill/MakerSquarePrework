class Customer
	attr_reader :name
	attr_accessor :cash

	def initialize (name, cash)
		@name = name
		@cash = cash
	end

	def review
		puts "CUSTOMER REVIEW: " + @name.upcase,
			 "----",
			 "Cash: $#{@cash}",
			 "#{@name} has #{self.all_accounts.length} accounts.",
			 "----"
		self.all_accounts.each {|x| puts x}
		puts "Net Worth: $#{self.net_worth}",
			 "----",
			 "----"
	end

	def all_accounts
		Account.account_list.select{|x| x.customer==self} + CreditCard.account_list.select{|x| x.customer==self}
	end

	def net_worth
		self.all_accounts.map{|x| x.balance}.inject(:+).round(2) + @cash
	end
end

class Bank
	attr_reader :name_of_bank

	def initialize(name_of_bank)
		@name_of_bank = name_of_bank
	end

	def review
		puts "BANK REVIEW:" + @name_of_bank.upcase,
			 "----",
			 "Number of Accounts: #{self.accounts_at_bank.size}",
			 "Number of Customers: #{self.accounts_at_bank.map{|x| x.customer}.uniq.size}",
			 "----"
		self.accounts_at_bank.each {|x| puts x}
		puts "Current Funds Deposited: $#{self.current_funds}",
			 "Current Credit Owed to Bank: $#{self.current_credit}",
			 "Current Bank Reserves: $#{(self.current_funds + self.current_credit).round(2)}",
			 "----",
			 "----"
	end

	def cash_accounts_at_bank
		Account.account_list.select{|x| x.bank==self}
	end

	def credit_accounts_at_bank
		CreditCard.account_list.select{|x| x.bank==self}
	end

	def accounts_at_bank
		self.cash_accounts_at_bank + self.credit_accounts_at_bank
	end

	def current_funds
		self.cash_accounts_at_bank.map{|x| x.balance}.inject(:+)
	end

	def current_credit
		self.credit_accounts_at_bank.map{|x| x.balance}.inject(:+)
	end
end

class Account
	attr_reader :customer, :bank
	attr_accessor :balance
	@@account_list = []

	def initialize(customer, bank, starting_balance)
		@customer = customer
		@balance = 0
		@bank = bank
		def not_for_child_class(customer, starting_balance)
			@@account_list << self
			@account_number = @@account_list.find_index(self) + 1
			self.deposit(customer, starting_balance)
		end
		self.not_for_child_class(customer, starting_balance) unless self.is_a? CreditCard
	end

	def self.account_list
		@@account_list
	end

	def self.print_all_accounts
		puts "TOTAL CASH ACCOUNTS AT ALL BANKS: #{@@account_list.size}\n----"
		@@account_list.each{|x| puts x}
		puts "TOTAL CREDIT ACCOUNTS AT ALL BANKS: #{CreditCard.account_list.size}\n----"
		CreditCard.account_list.each{|x| puts x}
	end

	def deposit(customer, amount)
		@balance += amount
		customer.cash -= amount
	end

	def withdraw(customer, amount)
		return nil if self.cancel_if_insufficient_funds(amount)
		@balance -= amount
		unless self.is_a? CreditCard
			customer.cash += amount 
		end
	end

	def self.transfer(from_acct, to_acct, amount)
		return nil if from_acct.cancel_if_insufficient_funds(amount)
		from_acct.balance -= amount
		to_acct.balance += amount
	end

	def to_s
		"Account Number: #{@account_number}\nCustomer: #{@customer.name}\nCurrent Balance: $#{@balance}\nBank: #{@bank.name_of_bank}\n-----"
	end

	def cancel_if_insufficient_funds(amount)
		if self.is_a? CreditCard
			if (@balance - amount) < @credit_limit
				puts "There are insufficient funds for this purchase!  Transaction cancelled!"
				return true
			end
		else
			if @balance < amount
				puts "There are insufficient funds for this withdrawal!  Transaction cancelled!"
				return true
			end
		end
	end
end

class CreditCard < Account
	@@creditcard_list = []
	@@apr = 0.13
	attr_accessor :balance
	attr_reader :account_number

	def initialize(customer, bank, credit_limit)
		@credit_limit = credit_limit * -1
		@@creditcard_list << self
		@account_number = "CC" + (@@creditcard_list.find_index(self) + 1).to_s
		super
		puts "NEW CREDIT ACCOUNT: #{@customer.name} opend credit card number #{@account_number}."
	end

	def to_s
		"Credit Card Account Number: #{@account_number}\nCredit Limit: $#{@credit_limit}\nCustomer: #{@customer.name}\nCurrent Balance: $#{@balance}\nBank: #{@bank.name_of_bank}\n-----"
	end

	def make_purchase(price)
		puts "CREDIT CARD PURCHASE FOR $#{price}"
		self.withdraw(self.customer, price)
	end

	def make_payment(amount)
		puts "CREDIT CARD PAYMENT FOR $#{amount}"
		self.deposit(self.customer, amount)
	end

	def self.charge_monthly_interest
		@@creditcard_list.each do |x| 
			interest_charge = (x.balance * @@apr / 12).round(2)
			x.balance -= interest_charge
			puts "#{x.account_number} was charged $#{interest_charge} in interest."
		end
	end

	def self.account_list
		@@creditcard_list
	end
end


