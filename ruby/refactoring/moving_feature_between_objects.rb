# before
class Account
  def overdraft_charge
    if @account_type.premium?
      result = 10
      result += (@day_overdrawn - 7) * 0.85 if @day_overdrawn > 7
    else
      @day_overdrawn * 1.75
    end
  end  

  def bank_charge
    result = 4.5
    result += overdraft_charge if @day_overdrawn > 0
    result
  end
end

# after
class AccountType
  def overdraft_charge(day_overdrawn)
    if premium?
      result = 10
      result += (day_overdrawn - 7) * 0.85 if day_overdrawn > 7
    else
      day_overdrawn * 1.75
    end
  end 
end

class Account
  def overdraft_charge
    @account_type.overdraft_charge(@day_overdrawn)
  end

  def bank_charge
    result = 4.5
    result += overdraft_charge if @day_overdrawn > 0
    result
  end
end

# finaly
class AccountType
  def overdraft_charge(day_overdrawn)
    if premium?
      result = 10
      result += (day_overdrawn - 7) * 0.85 if day_overdrawn > 7
    else
      day_overdrawn * 1.75
    end
  end
end

class Account
  def bank_charge
    result = 4.5
    if @day_overdrawn > 0
      result += @account_type.overdraft_charge(@day_overdrawn)
    end
    result
  end
end