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
