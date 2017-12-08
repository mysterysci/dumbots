## Ideas

- Analysis/Test: Use Rails system tests in 5.1 to simulate a bunch of bot-only 
  games to see which bots are best. 
- Bug fix: DecentBot sometimes disappears off the board.
- Refactor: Make Point#to_vector private.
- Refactor: BotBase doesn't require the Arena to move, but it does to fire. 
- Refactor: The $action_log global is a global, and that's not good.
- Game Play: Prevent bots from being in the same cell on the board at the same 
  time.
- Game Play: Add a third action called "defend" which allows a player to not
  do anything in order to gain Energy without spending any. 
- Game Play: Create your own bot to beat the built-in bot.
- Game Play: The game is currently a single-player against bots. Make it
  a multi-player human game. 
- UI: Change description when moving to same space to say "stands still".
- UI: It's hard to see who's winning / losing at a glance.
- UI: Allow user to pick how many total players (2-4) in a new game.
- UI: If Human dies early, have the game play out automatically. 
- UI: Animate the actions that happen.
