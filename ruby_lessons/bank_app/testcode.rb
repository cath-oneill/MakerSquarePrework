require_relative 'banking.rb'

bob = Customer.new("Robert Smith", 100)
big_bank = Bank.new("Big Texas Bank")
acct1 = Account.new(bob, big_bank, 150)
little_bank = Bank.new("Little State Bank")
acct2 = Account.new(bob, little_bank, 200)

Account.print_all_accounts
big_bank.print_accounts_at_bank

acct2.deposit(500)
acct1.withdraw(100)
acct2.withdraw(50)

Account.print_all_accounts

puts big_bank