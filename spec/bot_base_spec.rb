require_relative 'rails_helper'

describe BotBase do
  let(:bot) { BotBase.new(NullArena.new, Point.new(0, 0)) }

  it 'should move and reduce energy - moving one x coordinate' do
    bot.move_to(Point.new(1, 0))
    expect(bot.location).to eq Point.new(1, 0)
    expect(bot.energy).to eq 9.0
  end

  it 'should move and reduce energy - moving one diagonally' do
    bot.move_to(Point.new(1, 1))
    expect(bot.location).to eq Point.new(1, 1)
    expect(bot.energy).to eq (10.0 - 1.41)
  end

  it 'should fire at and reduce energy' do
    bot.fire_at(Point.new(1, 1))
    expect(bot.energy).to eq (10.0 - 1.41)
  end

  describe 'limited energy' do
    it 'moving horizontally' do
      bot.instance_variable_set('@energy', 1.0)
      bot.move_to(Point.new(2, 0))
      expect(bot.location).to eq Point.new(1, 0)
      expect(bot.energy).to eq 0.0
    end

    it 'moving diagonally with 1 energy snaps to grid' do
      bot.instance_variable_set('@energy', 1.0)
      bot.move_to(Point.new(4, 4))
      expect(bot.location).to eq Point.new(1, 1)
      expect(bot.energy).to eq 0.0
    end

    it 'moving diagonally with 0.5 energy snaps to grid' do
      bot.instance_variable_set('@energy', 0.5)
      bot.move_to(Point.new(4, 4))
      expect(bot.location).to eq Point.new(0, 0)
      expect(bot.energy).to eq 0.0
    end

    describe 'firing' do
      before do
        hash = {
          'bots' => [{'class' => 'BotBase',
                      'energy' => 1.0, 'health' => 10.0,
                      'location' => {'x' => 0, 'y' => 0}}]
        }
        arena = Arena.load(hash)
        @bot = arena.bots[0]
      end

      it 'firing horizontally' do
        @bot.fire_at(Point.new(2, 0))
        expect(@bot.health).to eq 9.0
      end

      it 'firing diagonally' do
        @bot.fire_at(Point.new(4, 4))
        expect(@bot.health).to eq 9.41
      end
    end
  end

  describe 'no energy' do
    it 'moving goes nowhere' do
      bot.instance_variable_set('@energy', 0.0)
      bot.move_to(Point.new(2, 0))
      expect(bot.location).to eq Point.new(0, 0)
      expect(bot.energy).to eq 0.0
    end

    describe 'firing' do
      before do
        hash = {
          'bots' => [{'class' => 'BotBase',
                      'energy' => 0.0, 'health' => 10.0,
                      'location' => {'x' => 0, 'y' => 0}}]
        }
        arena = Arena.load(hash)
        @bot = arena.bots[0]
      end

      it 'firing hits self' do
        @bot.fire_at(Point.new(2, 0))
        expect(@bot.health).to eq 8.0
      end
    end
  end
end

class NullArena
  def fire_at(point)
  end
end