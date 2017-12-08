class Dominator < BotBase
  def take_turn
    other_bot = @arena.not_dead_yet.detect { |b| b != self }
    fire_at(other_bot.location)
  end

  def to_hash
    super
  end
end