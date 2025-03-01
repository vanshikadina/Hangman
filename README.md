Hangman Game 🎭🔠

Features
Random Word Selection: Words are loaded from words.txt and converted to lowercase.
Keyboard Input Handling: Uses HashMap to track guessed letters.

Graphical Display:
Correctly guessed letters are revealed.
Incorrect guesses increase a wrongGuess counter, drawing the hangman step by step.
The game displays a scoreboard and a countdown timer for game resets.

Game Flow:
Players guess letters using the keyboard.
Winning occurs when all letters are guessed correctly.
Losing occurs after 5 incorrect guesses, revealing the correct word.
Players can abandon the game by pressing %.

Code Structure
setup(): Initializes game variables, loads words, and resets game state.
draw(): Handles game rendering, including the hangman figure, keyboard, and guessed letters.
keyPressed(): Manages input handling for correct and incorrect guesses.
reset(): Resets the game when needed.
drawhangMan(): Draws the hangman figure based on incorrect guesses.

How to Play
Run the game in Processing.
Type letters on the keyboard to guess the word.
Watch the hangman being drawn if you guess incorrectly.
Win by revealing the full word or lose after 5 incorrect guesses.
Press % to abandon the game and reset.
