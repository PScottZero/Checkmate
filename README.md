# Checkmate

UPDATE: I have recreated checkmate using Flutter. The recreation is called [En Passant](https://github.com/PScottZero/EnPassant), and is available on [Google Play](https://play.google.com/store/apps/details?id=com.pscottzero.en_passant). While it is not avaliable on the Apple App Store, it can be built to run on iOS devices.

Checkmate is a chess app programmed using SwiftUI, Core Data, and SpriteKit. The features of this chess app include:
* One-player gameplay with AI
* Two-player gameplay
* Timed games (For two-player games only)
* Proper enforcement of all chess rules
* Ability to add, edit, and delete users
* Leaderboard for all users
* Ability to save and load games
* Ability to change app theme

I created this app as my final project for my application development class at Penn State (CMPSC 475). We were tasked with created an app of our choosing to develop over a 5-week period. I decided to create a chess app after being inspired by the Netflix show <i>The Queen's Gambit</i>. Despite having little actual chess skill, I still felt that this would be a fun project to attempt.

## Building

This app does not require any external dependencies to work. Simply load the project into Xcode and build it normally. This app was developed mainly using the iPhone SE 2nd Gen simulator, but should also work for other iPhone models.

## Guide

When the app first starts, you will be shown the main menu. Here you can select how many players you want to play with. If you select one player, two other options will appear. The first allows you to change the difficulty of the AI that you play with (Easy, Normal, or Hard). The second option lets you choose which side you want to play on (Black or White). If you select the two-player game mode, one additional game option will appear. This option allows you to set the time limit for the game. The available options for time limits are Unlimited, 30min, 60min, 90min, 120min, and 150min.

<img src="https://live.staticflickr.com/65535/50707208212_2f1cdfb8ed_b.jpg" width="300"> <img src="https://live.staticflickr.com/65535/50706390538_4808cbf2e7_b.jpg" width="300">

By clicking on the "Select Player" button for each player, users will be brought to a player selection screen with all available player profiles. When the app initially starts, there will be no player profiles yet, so the user will need to add at least one if you plan on playing with an AI. If you plan on playing two-player games, two user profiles must be created. The user must add a name and can optionally add a profile picture from their phone. Once player profiles are created, a user just needs to tap on the player's list item to select them.

<img src="https://live.staticflickr.com/65535/50707126226_9427a19633_b.jpg" width="300"> <img src="https://live.staticflickr.com/65535/50630401326_0b36acd2df_b.jpg" width="300"> <img src="https://live.staticflickr.com/65535/50629656053_fc1ed95cfe_b.jpg" width="300">

A player's profile can be edited by clicking the info button on their list item. In the edit player view, a user can change a player's name, view the
wins and losses count for that player, view the player's rating (1200 + wins * 10 - losses * 10), reset the players wins and losses count, and can also delete the profile. The reset and delete actions will bring up a warning action to make sure the user is certain about their action. Keep in mind that if you delete a player, all saved games the player is associated with will also be deleted.

<img src="https://live.staticflickr.com/65535/50629680368_ba5eded607_b.jpg" width="300">

Once all players have been selected, the "Start" button on the main menu will become enabled. Clicking this button will bring up the chessboard view. This view
displays the chessboard. In one-player mode, there will be a status message that is displayed that will either display "Your Turn" if it is the player's turn to go, or "AI Is Thinking...", which is displayed while the AI is trying to make its move. For two-player games, each player's name, profile picture, and the time left is displayed on either side of the screen. There will also be a status message in the middle of the screen describing whose turn it is. If there is a timer, the timer for player 1 (white pieces) will immediately begin. When each player makes a move, their timer will stop and the other player's timer will begin counting down again. If a player's timer goes to zero, they automatically lose.

<img src="https://live.staticflickr.com/65535/50707126156_7760ef60c9_b.jpg" width="300"> <img src="https://live.staticflickr.com/65535/50707287946_2b65ab54dc_c.jpg" width="300">

When the player selects a chess piece, the valid moves for that piece will be displayed as blue squares on the chessboard. If a piece can take an enemy piece, then a blue square will appear over the enemy piece. Also, if at any point a player's king is in check, the king will have a red square appear behind it. All of chess's rules have been implemented and are enforced on the game board. For example, the game does not allow for a user to make a move that puts their king in check. The game ends when one of the player's kings is in checkmate. If a user does not think they will win the game but does not want to continue until checkmate, there is also a "Give Up" button which will make the player whose turn it is forfeit the game.

<img src="https://live.staticflickr.com/65535/50707196871_469f1d566e_b.jpg" width="300"> <img src="https://live.staticflickr.com/65535/50707278877_1dbb58f24f_b.jpg" width="300"> <img src="https://live.staticflickr.com/65535/50706460403_fd8d0e813e_b.jpg" width="300">

If you do not wish to finish a game, but would like to start it again later, you have the option to save the current game using the "Save" button on the chessboard view. Once the game is saved, the user is shown the main menu again. To load a game from the main menu, simply click on the "Load Game" button, and a list of all saved games will be shown. For each save, the players of the game, the time which the game was saved, and a screenshot of the game are shown. Simply click on the list item to start the selected game. If you wish to delete the game, press the "Delete Game" button.

<img src="https://live.staticflickr.com/65535/50706552878_e2f940fd10_c.jpg" width="300">

From the main menu, there is a "Leaderboard" button, which after clicking it will show a ranking of all users registered locally in the app. The users are all ranked by their rating. Each leaderboard item shows a user's ranking, their name, their wins and losses counts, and their overall rating. Also from the main menu, there is a gear icon that, when clicked, will bring up a settings sheet. Here, you can change the app's theme, which changes the appearance of the main menu and the chessboard. You also have the option to delete all players and delete all saved games if you so desire.

<img src="https://live.staticflickr.com/65535/50707126121_483f35ec19_b.jpg" width="300"> <img src="https://live.staticflickr.com/65535/50706390493_450c05c997_b.jpg" width="300">

Here are images of all of the app themes which are (from left to right): Bismuth, Blue, Green, Iridescent, Metallic, Opal, Red, Regal, and Vaporwave.

<img src="https://live.staticflickr.com/65535/50707216447_6f4719f485_b.jpg" width="300"> <img src="https://live.staticflickr.com/65535/50707134661_146a8ea840_b.jpg" width="300"> <img src="https://live.staticflickr.com/65535/50707216417_20cc4dd874_b.jpg" width="300"> <img src="https://live.staticflickr.com/65535/50706398398_e1ea1a9106_b.jpg" width="300"> <img src="https://live.staticflickr.com/65535/50707134636_74b3f9006f_b.jpg" width="300"> <img src="https://live.staticflickr.com/65535/50707134621_9209b2b8fc_b.jpg" width="300"> <img src="https://live.staticflickr.com/65535/50707134611_fbbccc3c3d_b.jpg" width="300"> <img src="https://live.staticflickr.com/65535/50706398323_f26fde4c2e_b.jpg" width="300"> <img src="https://live.staticflickr.com/65535/50707134501_96b83493f9_b.jpg" width="300">

## AI Description

The chess AI I developed for this app uses the alpha-beta pruning algorithm to calculate which moves to make. To learn more about how this algorithm works, use the following link: https://en.wikipedia.org/wiki/Alpha–beta_pruning. This source is what helped me code the actual AI as it has a pseudo-code example of the algorithm which I adapted for my app. In easy mode, the AI will only look at all possible moves it can make for its next move (search depth of 1). In normal mode, the AI will not only look at all possible moves it can make, but all possible moves the other player can make after the AI makes its move (search depth of 2). In hard mode, the AI will also look at the next move it can make after its opponent has made their move in response to the AI's first move (search depth 3).
