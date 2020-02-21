# you have a complicated expression
# before
if (platform.upcase.index('MAC') &&
    browser.upcase.ondex('IE') &&
    initialized? &&
    resize > 0
)
  # do something
end

# after
is_mac_os = platform.upcase.index('MAC')
is_ie_browser = browser.upcase.ondex('IE')
was_resized = resize > 0

if (is_mac_os && is_ie_browser && initialized? && was_resized)
  # do something
end

# example
# before
def price
  return @quantity * @item_price -
    [0, @quantity - 500].max * @item_price * 0.05 +
    [@quantity * @item_price * 0.1, 100.0].min
end

# after
# 1個ずつ一時変数にしていく
def price
  base_price = @quantity * @item_price
  quantity_discount = [0, @quantity - 500].max * @item_price * 0.05
  shipping = [@quantity * @item_price * 0.1, 100.0].min
  return base_price - quantity_discount + shipping
end

# 一時変数よりメソッドの摘出を好む
# メソッドはオブジェクトを通して実行したり他のオブジェクトにとって便利なため
# finally
def price
  base_price - quantity_discount + shipping
end

def base_price
  @quantity * @item_price
end

def quantity_discount
  [0, @quantity - 500].max * @item_price * 0.05
end

def shipping
  [base_price * 0.1, 100.0].min
end
