require_relative 'banking.rb'

bob = Customer.new("Robert Smith", 1000)
big_bank = Bank.new("Big Texas Bank")
acct1 = Account.new(bob, big_bank, 150)
little_bank = Bank.new("Little State Bank")
acct2 = Account.new(bob, little_bank, 200)
jenny = Customer.new("Jennifer Ronalds", 1500)
acct3 = Account.new(jenny, big_bank, 200)

acct2.deposit(bob, 500)
acct1.withdraw(bob, 50.25)
acct2.withdraw(bob, 50)
acct3.withdraw(jenny, 100)


acct1.withdraw(bob, 1000)


credit1 = CreditCard.new(jenny, big_bank, 1500)


credit1.make_purchase(500.10)
credit1.make_purchase(2000)
credit1.make_payment(230)

CreditCard.charge_monthly_interest


jenny.review
big_bank.review

Account.print_all_accounts

puts acct1
puts acct2
Account.transfer(acct2, acct1, 200)
puts acct1
puts acct2
Account.transfer(acct2, acct1, 1000)
puts acct1
puts acct2