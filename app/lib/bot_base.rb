require_relative 'arena'

class BotBase
  attr_reader :arena, :location, :energy, :health

  def initialize(arena, location)
    @arena = arena
    @location = location
    @energy = 10.0
    @health = 10.0
  end

  def emoji
    dead? ? '❌' : '🤖'
  end

  def add_energy(amount)
    @energy += amount
    @energy = @energy.round(2)
  end

  def move_to(point)
    @action = "#{self.class.name} moves towards #{point}"
    distance = use_energy_towards_point(point)
    destination = find_destination(point, distance)
    @action << ", reaches #{destination}"
    $action_log << @action
    @location = destination
  end

  def fire_at(point)
    @action = "#{self.class.name} fires towards #{point}"
    distance = use_energy_towards_point(point)
    destination = find_destination(point, distance)
    @action << ", hits #{destination}"
    $action_log << @action
    arena.fire_at(destination)
  end

  def defend

  end

  def damage!(amount)
    @health -= amount
    @health = @health.round(2)
  end

  def kill!
    @health = 0.0
  end

  def dead?
    @health <= 0.0
  end

  private

  def use_energy_towards_point(point)
    distance = [energy, @location.distance_to(point)].min.round(2)
    @action << ", using #{distance} energy"
    add_energy(-distance)
    distance
  end

  def find_destination(point, distance)
    move_vector = (point - location).to_vector
    move_vector = move_vector.normalize rescue move_vector
    move_vector = move_vector * distance
    (location + Point.from_vector(move_vector)).round(0)
  end

  def to_hash
    {
      class: self.class.name,
      location: @location,
      energy: @energy,
      health: @health,
    }
  end
end