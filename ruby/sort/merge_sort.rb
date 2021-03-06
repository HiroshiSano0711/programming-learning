require 'pry'

def mergesort!(input_array)
  mergesort(input_array.dup)
end

def mergesort(array)
  return array if array.size <= 1

  array2 = array.pop(array.size >> 1)
  merge(mergesort(array), mergesort(array2))
end

def merge(array1, array2)
  result = []

  loop {
    break if array1.size.zero?
    break if array2.size.zero?

    if array1.first <= array2.first
      result << array1.shift
    else
      result << array2.shift
    end
  }

  while array1.size.nonzero? do
    result << array1.shift
  end
  while array2.size.nonzero? do
    result << array2.shift
  end

  result
end
input_array = (1..30).to_a.shuffle
mergesort!(input_array)
