require 'rspec'
require 'pry-byebug'
require_relative '../banking.rb'

describe "banking app" do
	before do
		@bank1 = Bank.new("Bank of America")
		@bank2 = Bank.new("USA Bank")
		@customer1 = Customer.new("Jane Doe", 4000)
		@customer2 = Customer.new("John Doe", 5000)
		@acct1 = Account.new(@customer1, @bank1, 1200)
		@acct2 = Account.new(@customer2, @bank1, 1000)
		@credit1 = CreditCard.new(@customer1, @bank2, 2000)
		@credit2 = CreditCard.new(@customer2, @bank1, 8000)

		@acct1.deposit(@customer1, 100)
		@acct2.deposit(@customer2, 144)
		@credit1.make_purchase(500)
		@credit2.make_purchase(11)
	end

	describe "Customer" do
		describe ".net_worth" do
			it "total assets minus debt" do
				expect(@customer1.net_worth).to eq(4000-500)
				expect(@customer2.net_worth).to eq(5000-11)
			end
		end
	end

	describe "Bank" do

	end

	describe "Account" do
		describe ".deposit" do
			it "adds money to account and removes from cash on hand" do
				expect(@acct1.balance).to eq(1300)
				expect(@acct2.balance).to eq(1144)
				expect(@customer1.cash).to eq(2800 - 100)
				expect(@customer2.cash).to eq(4000 - 144)
			end
		end
	end

	describe "CreditCard" do
		describe ".make_purchase" do
			it "subtracts from credit card balance" do
				expect(@credit1.balance).to eq(-500)
				expect(@credit2.balance).to eq(-11)
				@credit1.make_purchase(412.90)
				expect(@credit1.balance).to eq(-500 - 412.90)
			end
		end
	end
end