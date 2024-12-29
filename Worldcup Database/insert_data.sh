#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $WINNER != winner ]]
  then
    # TEAMS DATABASE
    # Get winner and opponent teams id
    for TEAM in "$WINNER" "$OPPONENT" # Creates a loop in which the new variable TEAM gets the value of WINNER an d OPPONENT
      do
        TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$TEAM'") # Looks for the TEAM in the DB
        if [[ -z $TEAM_ID ]] # If the team does not exist
          then
            # Insert the team into the DB
            INSERT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$TEAM')")
            echo "$INSERT_RESULT $COUNT"
        fi
      done
    # GAMES DATABASE
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'") # Look for the WINNER id in DB.
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'") # Look for the OPPONENT id in DB.
     # Insert the game into the DB
    INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, winner_id, opponent_id, winner_goals, opponent_goals, round) VALUES($YEAR, $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS, '$ROUND')")
    echo "$INSERT_GAME_RESULT"
  fi
done