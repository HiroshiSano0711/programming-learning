
# # before
# def discount(input_val, quantity, year_to_date)
#   if input_val > 50
#     input_val -= 2
#   end
# end

# # after
# def discount(input_val, quantity, year_to_date)
#   result = input_val
#   if input_val > 50
#     result -= 2
#   end
# end

# # before
# def discount(input_val, quantity, year_to_date)
#   input_val -= 2 if input_val > 50
#   input_val -= 1 if quantity > 100
#   input_val -= 4 if year_to_date > 10000
#   input_val
# end

# # after
# def discount(input_val, quantity, year_to_date)
#   result = input_val
#   result -= 2 if input_val > 50
#   result -= 1 if quantity > 100
#   result -= 4 if year_to_date > 10000
#   result
# end

# # Use of pass by value often is a source of confusion
# x = 5
# def triple(arg)
#   arg *= 3
#   puts "arg in triple: #{arg}"
# end
# triple x
# puts "x after triple: #{x}"

class Ledger
  attr_reader :balance

  def initialize(balance)
    @balance = balance
  end

  def add(arg)
    @balance += arg
  end
end

class Product
  def self.add_price_by_updating(ledger, price)
    ledger.add(price)
    puts "ledger in add_price_by_updating: #{ledger.balance}"
  end

  def self.add_price_by_replacing(ledger, price)
    ledger = Ledger.new(ledger.balance + price)
    puts "ledger in add_price_by_replacing: #{ledger.balance}"
  end
end

l1 = Ledger.new(0)
Product.add_price_by_updating(l1, 5)
puts "l1 after add_price_by_updating: #{l1.balance}"

l2 = Ledger.new(0)
Product.add_price_by_replacing(l2, 5)
puts "l2 after add_price_by_replacing: #{l2.balance}"
