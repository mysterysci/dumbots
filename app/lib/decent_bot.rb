class DecentBot < BotBase
  def take_turn
    # select nearest bot
    nearest = find_nearest

    # if energy < x
    #   defend

    # sometimes need to move even when close to an opponent
    if (nearest[:distance_to] > 2.0) || a_third_of_the_time
      move_to(nearest[:bot].location + Point.new(0, 1))
    else
      fire_at(nearest[:bot].location)
    end
  end

  def find_nearest
    @arena.bots.
      select { |b| b != self && !b.dead? }.
      map { |b| {bot: b, distance_to: b.location.distance_to(location)} }.
      min { |a, b| a[:distance_to] <=> b[:distance_to] }
  end

  def to_hash
    super
  end

  def a_third_of_the_time
    33.percent_of_the_time
  end
end

class Fixnum
  def percent_of_the_time
    rand(100) <= self
  end
end