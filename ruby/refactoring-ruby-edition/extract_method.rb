# extract_method

# before
def print_banner(amount)
  print_banner
  puts "name: #{@name}"
  puts "amount: #{amount}"
end

# after
def print_owing(amount)
  print_banner
  print_detail(amount)
end

def print_detail(amount)
  puts "name: #{@name}"
  puts "amount: #{amount}"
end

#########################################
# no local valiable

# before
def print_owing
  outstanding = 0.0

  # print_banner
  puts "***********************"
  puts "**** Customer Owes ****"
  puts "***********************"

  # calculate outstanding
  @order.each do |order|
    outstanding += order.amount
  end

  # print_details
  puts "name: #{@name}"
  puts "amount: #{outstanding}"
end

# after
def print_owing
  outstanding = 0.0

  print_banner

  # calculate outstanding
  @order.each do |order|
    outstanding += order.amount
  end

  # print_details
  puts "name: #{@name}"
  puts "amount: #{outstanding}"
end

def print_banner
  puts "***********************"
  puts "**** Customer Owes ****"
  puts "***********************"
end

##############################################
# Using Local Variables

# before
def print_owing
  outstanding = 0.0

  print_banner

  # calculate outstanding
  @order.each do |order|
    outstanding += order.amount
  end

  # print_details
  puts "name: #{@name}"
  puts "amount: #{outstanding}"
end

def print_banner
  puts "***********************"
  puts "**** Customer Owes ****"
  puts "***********************"
end

# after
def print_owing
  outstanding = 0.0

  print_banner

  # calculate outstanding
  @order.each do |order|
    outstanding += order.amount
  end

  print_details(outstanding)
end

def print_banner
  puts "***********************"
  puts "**** Customer Owes ****"
  puts "***********************"
end

# 変数が読み込まれているけど変更されていないとき
# 引数としてパラメーターを渡すことでメソッドとして摘出できる。
def print_details(outstanding)
  puts "name: #{@name}"
  puts "amount: #{outstanding}"
end

##############################################
# Reassigning a Local Variable
# before
def print_owing
  outstanding = 0.0

  print_banner

  # calculate outstanding
  @order.each do |order|
    outstanding += order.amount
  end

  print_details(outstanding)
end

# after
def print_owing
  print_banner
  outstanding = calculate_outstanding
  print_details(outstanding)
end

# outstandingの変数は、事前に初期化されているだけで、この処理より前に変更や読み取りもされていない
# そのため、そのまま摘出したメソッドに移動させることができる。
def calculate_outstanding
  outstanding = 0.0
  @order.each do |order|
    outstanding += order.amount
  end
  outstanding
end

# ↓ テスト後、さらにCollection Closure Methodを使って短く書き直す
#   inject, select, collect, mapなどのメソッドはよく使う
def calculate_outstanding
  @order.inject(0.0) { |result, order| result + order.amount }
end

# 書き直す前に一度テストする理由
# 書き直したことが原因なのかそもそもメソッドの摘出がうまくいないのかを特定する必要が出るから

# 最初のコードが引数で受け取った値と計算するようになってる場合

# before
def print_owing(previous_amount)
  outstanding = previous_amount * 1.2

  print_banner

  # calculate outstanding
  @order.each do |order|
    outstanding += order.amount
  end

  print_details(outstanding)
end

# after
def print_owing(previous_amount)
  outstanding = previous_amount * 1.2
  print_banner
  outstanding = calculate_outstanding(outstanding)
  print_details(outstanding)
end

def calculate_outstanding
  @order.inject(0.0) { |result, order| result + order.amount }
end

# ↓ after test
def print_owing(previous_amount)
  print_banner
  outstanding = calculate_outstanding(previous_amount * 1.2)
  print_details(outstanding)
end
