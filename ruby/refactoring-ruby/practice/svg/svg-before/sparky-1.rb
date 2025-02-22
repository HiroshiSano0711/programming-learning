# デッドコードの削除
NUMBER_OF_TOSSES = 1000

def toss
  2 * (rand(2)*2 - 1)
end

def values(n)
  a = [0]
  n.times { a << (toss + a[-1]) }
  a
end

# SVGの文書構造に応じて簡単なメソッドを作る
def rect(centre_x, centre_y, width, height, fill, stroke, stroke_width)
  %Q{<rect x="#{centre_x - 2}\" y="#{centre_y - 2}"
  width="#{width}" height="#{height}"
  fill="#{fill}" stroke="#{stroke}" stroke-width="#{stroke_width}" />}
end

def text(x, y, msg, font_family, font_size, fill)
  %Q{<text x="#{x + 6}\" y="#{y + 4}"
    font-family="#{font_family}" font-size="#{font_size}"
    fill="#{fill}" >#{msg}</text>}
end

def line(x1, x2, y1, y2, stroke, stroke_width)
  %Q{<line x1="#{x1}" y1="#{y1}" x2="#{x2}" y2="#{y2}"
    stroke="#{stroke}" stroke-width="#{stroke_width}" />}
end

def polyline(points, fill, stroke, stroke_width)
  %Q{<polyline fill="#{fill}" stroke="#{stroke}" stroke-width="#{stroke_width}"
    points = "#{points.join(' ')}" />}
end

SQUARE_SIDE = 4
SPARK_COLOR = 'red'
def spark(centre_x, centre_y, value)
  "#{rect(centre_x - (SQUARE_SIDE / 2), centre_y - (SQUARE_SIDE / 2),
  SQUARE_SIDE, SQUARE_SIDE, SPARK_COLOR, 'none', 0)}
  #{text(centre_x + 6, centre_y + 4, value, 'Verdana', 9, SPARK_COLOR)}"
end

# グローバル変数を変数に
tosses = values(NUMBER_OF_TOSSES)
points = []
tosses.each_index { |i| points << "#{i},#{200 - tosses[i]}" }

data = %Q{<svg xmlns=\"http://www.w3.org/2000/svg\"
     xmlns:xlink=\"http://www.w3.org/1999/xlink\" >
  <!-- x-axis -->
  #{line(0, 200, NUMBER_OF_TOSSES, 200, '#999', 1)}
  #{polyline(points, 'none', '#333', 1)}
  #{spark(NUMBER_OF_TOSSES-1, 200 - tosses[-1], tosses[-1])}
</svg>}

# このHTTPラッパーはテストしにくい環境を強制しているので取り去る
# puts "Content-Type: image/svg+xml
# Content-Length: #{data.length}

puts data
