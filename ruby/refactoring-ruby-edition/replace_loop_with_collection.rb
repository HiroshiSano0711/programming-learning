# before
managers = []
employees.each do |e|
  managers << e if e.manager?
end

# after
managers = employees.select { |e| e.manager? }


# before
offices = []
employees.each { |e| offices << e.office }

# after
offices = employees.collect { |e| e.office }


# before
manager_offices = []
employees.each do |e|
  manager_offices << e.office if e.manager?
end

# after
manager_offices = employees.select { |e| e.manager? }
                           .collect { |e| e.office }

                           
# before
total = 0
employees.each { |e| total += e.salary}

# after
employees.inject(0) { |sum, e| sum + e.salary}