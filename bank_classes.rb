#bank_classes.rb
require 'digest/sha1'
class Customer
  attr_accessor :name, :password, :accounts
  def initialize (name,password)
    @name = name
    @password = password
    @accounts = []
  end
end

class Account
  attr_reader :account_number, :balance
  attr_accessor :customer, :acct_type

  def initialize ( balance, acct_number, acct_type)
    @balance = balance
    @acct_type = acct_type
    @account_number = acct_number
  end

  def deposit
    amount = 0
    until amount > 0
      puts "how much would you like to deposit?"
      print "$"
      amount = gets.chomp.to_f
    end
    @balance += amount
    puts "Your new balance is $ #{format('%0.2f', @balance)}"
  end

  def withdrawal
    amount = 0
    until amount > 0
      puts 'How much would you like to withdrawal?'
      print '$'
      amount = gets.chomp.to_f
    end

    #checking for available funds
    if @balance < amount
      @balance -= (amount + 25)
    else
      @balance -= amount
    end
    puts "Your new balance is $#{format('%0.2f', @balance)}"
  end
end
