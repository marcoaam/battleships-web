Feature: Starting the game
	In order to play battleships
	As a nostalgic player
	I want to start a new game

	Scenario: Registering
		Given I am on the homepage
		When I follow "New Game"
		Then I should see "What's your name?"

		When I fill in "player1_name" with ""
		And I press "Submit"
		Then I should see "What's your name?"

		When I fill in "player1_name" with "Marco"
		And I press "Submit"
		Then I should see "Hi Marco lets play Battleships!!!"
		And I should see "You have 5 ships to deploy"



	