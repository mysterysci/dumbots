class ArenaController < ApplicationController
  before_action :load_game

  def show
  end

  def move
    action = params[:player_action].to_sym
    location = Point.new(*params[:location].split(',').map(&:to_i))
    human = @arena.bots.detect { |bot| bot.is_a?(Human) }
    human.set_next_turn(action, location)
    @arena.execute_round
    save_game

    render partial: 'board'
  end

  def new
    session[:arena] = nil
    $action_log = []

    redirect_to '/'
  end

  private

  def load_game
    @arena = session[:arena]
    logger.info(@arena) if @arena.is_a?(Hash)
    bots = [DecentBot, Dominator]
    @arena ||= Arena.new([bots.sample, bots.sample, bots.sample, Human].shuffle)
    @arena = Arena.load(@arena) if @arena.is_a?(Hash)
  end

  def save_game
    session[:arena] = @arena
  end
end