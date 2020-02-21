# before
class Account
  def interest_for_amount_days(amount, days)
    @interest_rate * amount * days / 365
  end
end

# after
class Account
  def interest_for_amount_days(amount, days)
    @account_type.interest_rate * amount * days / 365
  end
end

class AccountType
  attr_accessor :interest_rate
end

# using self-encapsulation
# before
class Account
  attr_accessor :interest_rate

  def interest_for_amount_days(amount, days)
    interest_rate * amount * days / 365
  end
end

# after
class Account
  def interest_for_amount_days(amount, days)
    interest_rate * amount * days / 365
  end

  def interest_rate
    @account_type.interest_rate
  end
end
# or
class Account
  extend Forwardable

  def_delegator :@account_type, :interest_rate, :interest_rate=

  def interest_for_amount_days(amount, days)
    interest_rate * amount * days / 365
  end
end
