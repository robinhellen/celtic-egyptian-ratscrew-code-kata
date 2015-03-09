# Third kata session for Celtic Egyptian Ratscrew game

## Problem: make the game playable
Your aim in this kata is to create a minimal console-based game, which will allow a few players to play against one another. We've given you a head start in the `kata3-start` branch, where you'll find code that allows users to add themselves as a player and to set their key bindings for playing a card and snapping. Your task is to process the incoming keystrokes once the game has started and show the progress of the game in the console.

## Learning objective: hook up all of the components of the application while maintaining good design.
Write as little code as possible in Main(). You can change any existng classes but consider what functionality you can add by creating new classes. Keep your eye on giving each class a single responsibility. Consider whether there are existing design patterns (e.g. [Command Pattern](http://en.wikipedia.org/wiki/Command_pattern)) that you could apply appropriately. 

## Tasks
We recommend you start by checking out the `kata3-start` branch and working from there. 

Before you start, run the console application to get an idea of what it currently does. You will be prompted to add a number of players, and for each playing asked to set up some key bindings. Currently the applcation stores the player name alongside the bindings, but doesn't do anything else with them.

Ignore any key presses that aren't bound to actions and don't enforce the order of play.

Extend the console app so that it

1. reads the user input from the `UserInterface` object
2. determines the corresponding action (e.g. laying a card for Joe, or snapping the stack for Bob) and
  * carries out the action
  * writes the action to the Console (e.g. "Joe has played the 8 of Clubs")
  * writes the state of the game to the console once the action has been carried out, including:
    * Top card of the stack
    * Whose turn is next
    * How many cards each player has in their pile
    * How many cards are on the stack
3. terminates the game once there is a winner
