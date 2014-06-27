require 'rspec'
require 'pry-byebug'
require_relative '../banking.rb'

describe "banking app" do
	before :each do
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
		describe ".current_funds" do
			it "adds all funds in deposit accounts" do
				expect(@bank1.current_funds).to eq(1200+1000+244)
			end
		end
	
		describe ".current_credit" do
			it "adds up all debt the bank has via credit cards" do
				expect(@bank1.current_credit).to eq(-11)
			end
		end

		describe ".current_bank_reserves" do
			it "Current Funds - Current Credit" do
				expect(@bank1.current_bank_reserves).to eq(2433)
			end
		end
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

		describe ".withdraw" do
			it "removes money from account and adds to cash on hand" do
				@acct1.withdraw(@customer2, 98)
				@acct2.withdraw(@customer2, 75)
				expect(@acct1.balance).to eq(1300-98)
				expect(@acct2.balance).to eq(1144-75)
				expect(@customer2.cash).to eq(3856 + 98 + 75)
			end
		end

		describe "#transfer" do
			it "subtracts money from one accout and adds to another" do
				Account.transfer(@credit1, @acct1, 700)
				Account.transfer(@acct1, @acct2, 712.90)
				expect(@credit1.balance).to eq(-1200)
				expect(@acct1.balance).to eq(1300 - 12.90)
				expect(@acct2.balance).to eq(1144 + 712.90)
			end	

			it "cancels transfer if insufficient funds" do
				Account.transfer(@credit1, @acct1, 2500)
				Account.transfer(@acct1, @acct2, 2500)
				expect(@acct1.balance).to eq(1300)
				expect(@acct2.balance).to eq(1144)
				expect(@credit1.balance).to eq(-500)
			end
		end
	end

	describe "CreditCard" do
		describe ".make_purchase" do
			it "subtracts from credit card balance" do
				expect(@credit1.balance).to eq(-500)
				expect(@credit2.balance).to eq(-11)
				@credit1.make_purchase(412.90)
				expect(@credit1.balance).to eq(-912.90)
			end
		end

		describe ".make_payment" do
			it "adds money to credit card balance" do
				@credit2.make_payment(11)
				expect(@credit2.balance).to eq(0)
			end
		end

		describe "#charge_monthly_interest" do
			it "adds interest to credit cards, lowering balance" do
				expect(@credit1.balance).to eq(-500)
				expect(@credit2.balance).to eq(-11)
				CreditCard.charge_monthly_interest
				expect(@credit1.balance).to eq(-505.42)
				expect(@credit2.balance).to eq(-11.12)
			end
		end

		describe "#number_of_accounts" do
			it "provides total number of credit accounts" do
				number = CreditCard.number_of_accounts
				creditcardtest = CreditCard.new(@customer2, @bank1, 1200)
				expect(CreditCard.number_of_accounts).to eq(number + 1)
			end
		end
	end
end