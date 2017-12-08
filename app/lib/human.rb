class Human < BotBase
  def emoji
    '🙂'
  end

  def take_turn
    self.send(@next_turn[:action], @next_turn[:point])
  end

  def set_next_turn(action, point)
    @next_turn = {action: action, point: point}
  end

  def to_hash
    super
  end
end