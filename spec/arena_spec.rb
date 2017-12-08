require_relative 'rails_helper'

describe Arena do
  describe 'fire_at' do
    let(:a) { Arena.new([BotBase]) }
    let(:bot) { a.bots[0] }

    it 'should give full damage to bot on point' do
      a.fire_at(bot.location)
      expect(bot.health).to eq 8.0
    end

    it 'should give half damage to bot 1.0 distance away' do
      a.fire_at(bot.location + Point.new(1, 0))
      expect(bot.health).to eq 9.0
    end

    it 'should give reduced damage to bot diagonally 1 square away' do
      a.fire_at(bot.location + Point.new(1, 1))
      expect(bot.health).to eq (10.0 - (2.0 - 1.41))
    end

    it 'should give no damage to bot 2.0 distance away' do
      a.fire_at(bot.location + Point.new(2, 0))
      expect(bot.health).to eq 10.0
    end

    it 'should give no damage to bot 3.0 distance away' do
      a.fire_at(bot.location + Point.new(0, 3))
      expect(bot.health).to eq 10.0
    end
  end

  it 'should not give dead bots energy' do
    a = Arena.new([SelfDestruct, Dominator, SelfDestruct])
    loser = a.bots[0]
    dom = a.bots[1]

    loser.kill!

    a.execute_round
    expect(loser.energy).to eq 10.0
  end

  it 'should not apply fire damage to dead bots' do
    a = Arena.new([SelfDestruct, Dominator, SelfDestruct])
    loser_a = a.bots[0]
    dom = a.bots[1]
    loser_b = a.bots[2]

    loser_a.kill!

    a.execute_round
    expect(loser_a.health).to eq 0.0
    expect(loser_b.health).to eq 8.0
  end

  it 'should have 2 bots battle' do
    a = Arena.new([SelfDestruct, Dominator])
    loser = a.bots[0]
    dom = a.bots[1]
    expect(loser.location).to eq Point.new(1, 1)
    expect(dom.location).to eq Point.new(3, 3)
    a.execute_round

    expect(loser.health).to eq (10-2.0-2.0)
    expect(loser.energy).to eq (12.0)
    expect(dom.health).to eq (10.0)
    expect(dom.energy).to eq (9.17)

    expect(a.game_over?).to be_falsey
    expect(a.winner).to be_nil

    2.times { a.execute_round }
    expect(loser.dead?).to be_truthy
    expect(dom.dead?).to be_falsey

    expect(a.game_over?).to be_truthy
    expect(a.winner).to eq dom

    dom.instance_variable_set('@health', 0.0)
    expect(a.winner).to be_nil
    expect(a.game_over?).to be_truthy
  end

  describe 'load' do
    it 'should like ... work' do
      hash = {"bots" =>
                [{"class" => "DecentBot",
                  "location" => {"x" => 0, "y" => 1},
                  "energy" => 9.5,
                  "health" => 1.0},
                 {"class" => "Human",
                  "location" => {"x" => 4, "y" => 3},
                  "energy" => 5.0,
                  "health" => 9.21}]}

      arena = Arena.load(hash)
      decent = arena.bots[0]
      expect(decent.location).to eq Point.new(0, 1)
      expect(decent.energy).to eq 9.5
      expect(decent.health).to eq 1.0

      human = arena.bots[1]
      expect(human.location).to eq Point.new(4, 3)
      expect(human.energy).to eq 5.0
      expect(human.health).to eq 9.21
    end
  end
end

class SelfDestruct < BotBase
  def take_turn
    fire_at(@location)
  end
end
