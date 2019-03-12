#the_bank.rb
require_relative 'bank_classes'

@customers = []

def welcome_screen
  clear_screen
  @current_customer = ''

  puts 'Welcome to the Bank of Savage'
  puts 'Please choose from the following'
  puts '--------------------------------'
  puts '1. Customer Sign-In'
  puts '2. New Customer Registration'

  choice = gets.chomp.to_i
  case choice
  when 1
    sign_in
  when 2
    sign_up('','')
  else
    puts "Invalid Selection"
    welcome_screen
  end

end

def sign_in
  clear_screen
  print "What's your name? "
  name = gets.chomp
  print "what's your password "
  password = Digest::SHA1.hexdigest gets.chomp  + name.downcase
  customer_exists = false
  @customers.each do |customer|
    if name == customer.name && password == customer.password
      @current_customer = customer
      customer_exists = true
    end
  end
  if customer_exists
    account_menu
  else
    puts 'No customer found with that information'
    puts '1. Try again?'
    puts '2. Sign up'

    choice = gets.chomp.to_i

    case choice
    when 1
      sign_in
    when 2
      sign_up(name,password)
    else
      puts "Invalid Selection"
    end
  end
end

def sign_up(name, password)
  clear_screen
  if name == '' && password == ''
    print "what's your name?  "
    name = gets.chomp
    print "What's your password? "
    password = Digest::SHA1.hexdigest gets.chomp + name.downcase
  end
  @current_customer = Customer.new(name, password)
  @customers.push(@current_customer)
  puts "Registration Successful"

  account_menu
end

def account_menu
  clear_screen
  puts "Account Menu"
puts "---------------"
puts "1. Create an Account"
puts "2. Review an Account"
puts "3. Sign Out"

choice = gets.chomp.to_i

case choice
when 1
  create_account
when 2
  review_account
when 3
  puts "Thanks for banking with Savage Bank"
  welcome_screen
else
  puts "Invalid Selection"
  account_menu
end
end

def create_account
  clear_screen
  puts "What type of account would you like to open? "
  acct_type = gets.chomp
  amount = 0
  until amount > 0
    puts "How much will your first depoiste be? "
    print "$"
  amount = gets.chomp.to_f
  end
  new_acct = Account.new(amount, (@current_customer.accounts.length+1), acct_type)
  @current_customer.accounts.push(new_acct)
  puts "Account created Successfully!"
  account_menu
end

def review_account
  clear_screen
  if @current_customer.accounts.empty?
    puts "No accounts available"
    puts "Press 'enter' to continue"
    gets.chomp
    account_menu
  end
  @current_account = ""
  @current_customer.accounts.each do |x|
    puts "Current accounts #{x.acct_type}" if x.customer == @current_customer
  end
  print "Which account (type) do you want to review? "
  type = gets.chomp.downcase

  account_exists = false
  @current_customer.accounts.each do |account|
    if type == account.acct_type.downcase
      @current_account = account
      account_exists = true
        puts account.acct_type.downcase
    end
  end

  if account_exists
    current_account_actions
  else
  puts "Try Again"
  review_account
  end

end

def current_account_actions
  puts "Choose from the following:"
  puts "---------------------------"
  puts "1. Balance Check"
  puts "2. Make a Deposit"
  puts "3. Make a Withdrawal"
  puts "4. Return to Account Menu"
  puts "5. Sign Out"

  choice = gets.chomp.to_i

  case choice
  when 1
    clear_screen
    puts "Current balance is $#{format('%0.2f', @current_account.balance)} "
    current_account_actions
  when 2
    clear_screen
    @current_account.deposit
    current_account_actions
  when 3
    clear_screen
    @current_account.withdrawal
    current_account_actions
  when 4
    account_menu
  when 5
    welcome_screen
  else
    puts "Invalid Selection"
    current_account_actions
  end
end
def clear_screen
  system "cls" or system "clear"
end

welcome_screen
