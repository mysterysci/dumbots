require 'rails_helper'

describe Human do
  let(:arena) { Arena.new([BotBase, Human]) }
  let(:bot) { arena.bots[0] }
  let(:human) { arena.bots[1] }

  it 'sets next turn to move' do
    human.set_next_turn(:move_to, Point.new(0, 4))

    expect(human.location).to eq Point.new(3, 3)
    human.take_turn
    expect(human.location).to eq Point.new(0, 4)
    expect(human.energy).to eq 6.84
  end

  it 'sets next turn to fire' do
    human.set_next_turn(:fire_at, Point.new(1, 1))

    expect(human.location).to eq Point.new(3, 3)
    human.take_turn
    expect(human.location).to eq Point.new(3, 3)
    expect(human.energy).to eq 7.17

    expect(bot.health).to eq 8.0
  end
end