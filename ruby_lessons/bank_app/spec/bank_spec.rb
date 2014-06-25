require 'rspec'
require 'pry-byebug'
require_relative '../banking.rb'

describe "Customer" do
	describe "#new" do
		it "takes two parameters and returns customer" do
			# setup/execution
			@customer = Customer.new("Customer Name", 500)

			# expectation
			expect(@customer.class).to eq(Customer)
		end
	end
end

describe "Bank" do
	describe "#new" do
		it "takes 1 parameter and returns bank" do
			@bank = Bank.new("Bank Name")
			expect(@bank.class).to eq(Bank)
		end
	end
end
