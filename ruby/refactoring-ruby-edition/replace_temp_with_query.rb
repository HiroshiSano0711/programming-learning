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
