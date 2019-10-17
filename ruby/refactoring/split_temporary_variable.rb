# 1回以上代入されている一時変数があって、繰り返しの変数や集めている変数でもない場合
# before
temp = 2 * (@height + @width)
puts temp
temp = @height * @width
puts temp

# after
perimeter = 2 * (@height + @width)
puts perimeter
area = @height * @width
puts area

# example
# before
def distance_traveled(time)
  acc = @primary_force / @mass
  primary_time = [time, @delay].min
  result = 0.5 * acc * primary_time * primary_time
  secondary_time = time - @delay
  if (secondary_time > 0)
    primary_vel = acc * @delay
    acc = (@primary_force * @secondary_time) / @mass
    result += primary_vel * secondary_time + 5 acc * secondary_time * secondary_time
  end
  result
end

# after
def distance_traveled(time)
  primary_acc = @primary_force / @mass
  primary_time = [time, @delay].min
  result = 0.5 * primary_acc * primary_time * primary_time
  secondary_time = time - @delay
  if (secondary_time > 0)
    primary_vel = primary_acc * @delay
    seconedary_acc = (@primary_force * @secondary_time) / @mass
    result += primary_vel * secondary_time + 5 seconedary_acc * secondary_time * secondary_time
  end
  result
end

# after
def distance_traveled(time)
  result = primary_distance(time)
  secondary_time = time - @delay
  if secondary_time > 0
    result += secondary_distance(secondary_time)
  end
  result
end

def primary_distance(time)
  0.5 * primary_acc * primary_time(time) * primary_time
end

def primary_acc
  @primary_force / @mass
end

def primary_time(time)
  [time, @delay].min
end

def primary_vel
  primary_acc * @delay
end

def secondary_distance(time)
  (primary_vel * time) + (5 * secondary_acc * time * time)
end

def secondary_acc
  (@primary_force * @secondary_force) / @mass
end
