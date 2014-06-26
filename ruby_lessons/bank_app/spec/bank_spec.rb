require 'rspec'
require 'pry-byebug'
require_relative '../banking.rb'

describe "banking app"
	before do
		@bank1 = Bank.new("Bank of America")
		@customer1 = Customer.new("Jane Doe")
		@customer2 = Customer.new("John Doe")
		@acct1 = Account.new(@customer1, @bank1, 1000)
		@acct2 = Account.new(@customer2, @bank2, 1000)
	end

	describe "Customer" do
		describe "#new" do
			it "takes two parameters and instantiates customer and assigns name and cash" do
				# setup/execution
				customer1 = Customer.new("Customer Name", 500)

				# expectation
				expect(customer1.name).to eq("Customer Name")
				expect(customer1.cash).to eq(500)
			end
		end
	end

	describe "Bank" do
		describe "#new" do
			it "takes 1 parameter and returns bank" do
				bank1 = Bank.new("Bank Name")
				expect(bank1.name).to eq("Bank Name")
			end
		end
	end

	describe "Account" do

	end
end