class Rectangle
  attr_reader :width, :height

  def initialize(top_left, width, height)
    @top_left = top_left
    @width = width
    @height = height
  end

  def left_edge
    @top_left.x
  end
end

class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end
end

rect = Rectangle.new(Point.new(6.3, 5.0), 2.0, 2.0)
p rect.left_edge
