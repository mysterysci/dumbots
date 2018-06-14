## Dumbots

Welcome to Dumbots! It's a game. Not a great game, mind you, which is why it
has this super-clever title. 

[Go Play It Now!](https://dumbots.herokuapp.com/)

But let's shoot straight, this is an interview code exercise thingamabob. So
what's the exercise? The exercise is up-to-you! There are several ideas below
(in the also-cleverly named "Ideas" section), but feel free to come up with
your own idea as well!

### Uh, You Know Your "Game" Here _Really_ Sucks, Right?

Oh, absolutely. It's ridiculous. 

### How Do I Know What You're Looking For?

We're looking for broad things: what interests you, how you go about tackling
a problem or an enhancement in an existing codebase, and how you interact with
us on a Pull Request.

What you choose to work on is up to you so you can highlight your strengths.
How you work on it and interact with us is more important to us than what you
work on.

### Can I Submit a PR Early and Continue Pushing As I Go?

Please! That would be our preference so we can do some code-review with you
along the way.

### Is This Game Representative of the Work You're Hiring For?

On the face of it, not at all. But it has enough Rails in it you can work on
some Rails things if you want. It has enough UI stuff in it you can work on
that. It has enough OOP stuff in it you can work on that. Whether users are
interacting with our site for business vs. entertainment reasons is secondary
to how we build the things we build.

Plus, we'd rather the take-home part of the coding interview to be somewhat
entertaining to try and help offset the potential drudgery of working on
something that's all Business(TM)-y and stuff.

### How Much Time Should I Put Into It?

We know we're imposing on your personal time to do this for us, so you can
decide how much you'd like to spend on it. Things that you'd like to continue
doing but don't want to take the time on, add to the codebase as TODOs or as a
separate .md file.

Some of our Ideas are probably more time intensive than others, so you can do a
few small ones or one big one or whatever floats your fancy.

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
