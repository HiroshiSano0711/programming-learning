require 'pry'

# 自然マージソートになっていないので書き換える必要がある
input_array = (1..30).to_a.shuffle
$f = input_array.dup
$fa = []
$fb = []

def nmsort!
  loop do 
    distribution
    break if $fb.size.zero?
    merge
  end
end

def distribution
  while $f.size.nonzero? do
    copy_a_run($fa)

    break if $f.size.zero?

    copy_a_run($fb)
  end
end

def copy_a_run(array)
  old = $f.shift
  array << old
  while $f.size.nonzero? && old < $f.first
    array << $f.first
    old = $f.shift
  end
end

def merge
  while !$fa.size.zero? && !$fb.size.zero?
    if $fa.first < $fb.first
      $f << $fa.shift
    else
      $f << $fb.shift
    end
  end

  $f << $fa.shift while $fa.size.nonzero?
  $f << $fb.shift while $fb.size.nonzero?
end

nmsort!
p input_array
