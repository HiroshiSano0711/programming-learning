require 'benchmark'

num_rows = 100_000
num_cols = 10

data = Array.new(num_rows) { Array.new(num_cols) { 'a' * 1000 } }

puts "%d MB" % (`ps -o rss= -p #{Process.pid}`.to_i/1024)

time = Benchmark.realtime do
    csv = ''
    num_rows.times do |i|
        num_cols.times do |j|
            csv << data[i][j]
            csv << "," unless j == num_cols - 1
        end
        csv << "\n" unless i == num_rows - 1
    end
end

puts "%d MB" % (`ps -o rss= -p #{Process.pid}`.to_i/1024)
puts time.round(2)
