$action_log = []

class Arena
  attr_reader :bots

  def self.load(hash)
    new([]).tap do |arena|
      hash['bots'].each do |bot_data|
        location = Point.new(bot_data['location']['x'], bot_data['location']['y'])
        klass = Object.const_get(bot_data['class'])
        bot = klass.new(arena, location)
        bot.instance_variable_set('@energy', bot_data['energy'])
        bot.instance_variable_set('@health', bot_data['health'])
        arena.bots << bot
      end
    end
  end

  def initialize(bot_classes)
    spawns = [
      Point.new(1, 1), Point.new(3, 3), Point.new(1, 3), Point.new(3, 1)
    ]
    @bots = bot_classes.map.with_index do |bot_class, idx|
      bot_class.new(self, spawns[idx])
    end
  end

  def bots_at(x, y)
    @bots.select { |bot| bot.location == Point.new(x, y) }
  end

  def fire_at(point)
    not_dead_yet.each do |bot|
      distance = bot.location.distance_to(point)
      damage_dealt = [2.0 - distance, 0.0].max.round(2)
      $action_log << "#{bot.class.name} receives #{damage_dealt} damage" if damage_dealt > 0.0
      bot.damage!(damage_dealt)
    end
  end

  def execute_round
    $action_log.clear
    unless game_over?
      $action_log << 'All players receive 2.0 energy'
      not_dead_yet.map do |bot|
        bot.add_energy(2.0)
        bot.take_turn
      end
    end
  end

  def to_hash
    {bots: @bots}
  end

  def winner
    not_dead_yet[0] if not_dead_yet.length == 1
  end

  def game_over?
    not_dead_yet.length <= 1
  end

  def not_dead_yet
    @bots.select { |b| !b.dead? }
  end
end