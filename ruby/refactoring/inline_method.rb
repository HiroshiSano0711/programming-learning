##### Inline Method ######
# before
def get_rating
  more_than_five_late_delivers ? 2 : 1
end

def more_than_five_late_delivers
  @number_of_late_delivers > 5
end

# after
def get_rating
  @number_of_late_delivers > 5 ? 2 : 1
end

##### Inline Temp #####
# before
base_price = an_order.base_price
return (base_price > 1000)

# メソッド呼び出しの値を代入された一時的な変数
# 多くの場合メソッド呼び出しの代わりをしているだけで、安全にメソッド呼び出しに置き換えられる

# after
return (an_order.base_price > 1000)

##### Replace Temp with Query #####
# before
base_price = @quantity * @item_price
if base_price > 1000
  base_price * 0.95
else
  base_price * 0.98
end

# after
if base_price > 1000
  base_price * 0.95
else
  base_price * 0.98
end

def base_price
  @quantity * @item_price
end

# exmaple 2
# first step
def price
  base_price = @quantity * @item_price
  if base_price > 1000
    discount_factor = 0.95
  else
    discount_factor = 0.98
  end
  base_price * discount_factor
end

# second step
def price
  a_base_price = base_price
  if a_base_price > 1000
    discount_factor = 0.95
  else
    discount_factor = 0.98
  end
  a_base_price * discount_factor
end

def base_price
  @quantity * @item_price
end

# third step
def price
  a_base_price = base_price
  if base_price > 1000
    discount_factor = 0.95
  else
    discount_factor = 0.98
  end
  a_base_price * discount_factor
end

def base_price
  @quantity * @item_price
end

# forth step: remove temp variable
def price
  if base_price > 1000
    discount_factor = 0.95
  else
    discount_factor = 0.98
  end
  base_price * discount_factor
end

def base_price
  @quantity * @item_price
end

# finally
def price
  a_discount_factor = discount_factor # 一時変数の形になったので取り除ける
  base_price * a_discount_factor
end

# ↓ 最終的にこの形にできる
def price
  base_price * discount_factor
end

def base_price
  @quantity * @item_price
end

def discount_factor
  base_price > 1000 ? 0.95 : 0.98
end
