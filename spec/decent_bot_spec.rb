require 'rails_helper'

describe DecentBot do
  let(:arena) { Arena.new([BotBase, DecentBot]) }
  let(:other) { arena.bots[0] }
  let(:bot) { arena.bots[1] }

  describe 'take_turn' do
    it 'should move if more than 2 away' do
      def bot.a_third_of_the_time
        false
      end

      other.location.x = 0
      other.location.y = 0

      expect(bot.location).to eq Point.new(3, 3)
      bot.take_turn
      expect(bot.location).to eq Point.new(0, 1)
      expect(bot.energy).to eq 6.39

      expect(other.health).to eq 10.0
    end

    it 'should move instead of fire a third of the time' do
      def bot.a_third_of_the_time
        true
      end

      other.location.x = bot.location.x
      other.location.y = bot.location.y

      expect(bot.location).to eq Point.new(3, 3)
      bot.take_turn
      expect(bot.location).to eq Point.new(3, 4)
      expect(bot.energy).to eq 9.0

      expect(other.health).to eq 10.0
    end

    it 'should fire if 2 away' do
      def bot.a_third_of_the_time
        false
      end

      other.location.x = 1
      other.location.y = 3

      expect(bot.location).to eq Point.new(3, 3)
      bot.take_turn
      expect(bot.location).to eq Point.new(3, 3)
      expect(bot.energy).to eq 8.0

      expect(other.health).to eq 8.0
    end
  end

  describe 'find_nearest' do
    it 'does not find self'

    it 'finds nearest'

    it 'does not find a dead bot' do
      other.instance_variable_set('@health', 0.0)
      expect(other.dead?).to be_truthy
      expect(bot.find_nearest).to be_nil
    end
  end
end