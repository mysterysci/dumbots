require 'matrix'

class Point
  include Comparable

  attr_accessor :x, :y

  def self.from_vector(v)
    self.new(*v.to_a)
  end

  def initialize(x, y)
    @x = x
    @y = y
  end

  def <=>(other)
    return nil unless other.is_a?(Point)
    [x, y] <=> [other.x, other.y]
  end

  def inspect
    "(#{x}, #{y})"
  end

  def to_s
    inspect
  end

  def distance_to(point)
    Math.sqrt((point.x - x)**2 + (point.y - y)**2).round(2)
  end

  def to_vector
    Vector[@x, @y]
  end

  def +(other)
    Point.from_vector(to_vector + other.to_vector)
  end

  def -(other)
    Point.from_vector(to_vector - other.to_vector)
  end

  def round(places)
    Point.new(@x.round(places), @y.round(places))
  end
end