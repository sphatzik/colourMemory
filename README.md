# colourMemory
Memory Card Game

**An implementation of a 16 card memory game.  The player must flip two cards at a time in order to find a match.  Everytime that the player finds a matching pair wins 2 points, if he does not find a matching pair he loses 1 point. The game ends only if the player had successfully find all the matching pairs, then a pop up warning appears and asks from  the user to enter his name, finaly the app pushes a new tableviewController with the high scores.**



Below you can see a preview of the game:

![ScreenShot](https://cloud.githubusercontent.com/assets/2478249/13667281/42aa694a-e6be-11e5-88a5-89ee74b51a0d.gif)

**ViewController:**

 1. The VC initialises the card of the deck and gives a random number to each card. (Card with two properties: btnNumber and cardName)
 2. Each time the user taps on card the button reveals the card that is assigned to the card.
 3. When the user taps a second card the user interaction is disabled.
 4. If the cards that the user chose are the same colour the controller removes them from the view, gives 2 points to the user and enables user interaction again.
 5. If are not the same colour the controller flips those cards and takes 1 point from the user and enables user interaction.
 6. When all the cards have been removed from the view successfully the controller puts on the view a warning message with the input text field so the user can enter his name (no null inputs allowed.)
 7. It stores then the score and the username in the User Defaults using a Dictionary.

**HighScoreViewController:**

1. This Controller is a TableviewController that retrieves the entries from the User Defaults.
2. Populates the cells of the Table with the entries of the Dictionary and the high score are presented in a descending order.
3. By hitting the back button the user can return to the game.

 
