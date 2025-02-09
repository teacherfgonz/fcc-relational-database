#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=guessing_game -t --no-align -c"
SECRET_NUMBER=$(( (RANDOM % 1000) + 1 ))
NUMBER_OF_GUESSES=1

GUESSING() {
  local message="$1" 

  if [[ -z "$message" ]]; then
    message=$'\nGuess the secret number between 1 and 1000:'
  fi

  echo -e "$message"
  read USER_GUESS

  if [[ "$USER_GUESS" =~ ^[0-9]+$ ]]; then 
    if [[ "$USER_GUESS" -lt "$SECRET_NUMBER" ]]; then
      NUMBER_OF_GUESSES=$((NUMBER_OF_GUESSES + 1))
      GUESSING "\nIt's higher than that, guess again:"
    elif [[ "$USER_GUESS" -gt "$SECRET_NUMBER" ]]; then
      NUMBER_OF_GUESSES=$((NUMBER_OF_GUESSES + 1))
      GUESSING "\nIt's lower than that, guess again:"
    else
      echo -e "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
      REGISTER_IN_DB  # Call REGISTER_IN_DB after the game ends
      return 0        # Return success
    fi
  else
    GUESSING "That is not an integer, guess again:"
  fi
}

REGISTER_IN_DB() {
  if [[ -n "$DB_USER" ]]; then
    DB_USER_BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE user_id=$DB_USER;")
    if [[ $DB_USER_BEST_GAME -lt $NUMBER_OF_GUESSES ]]
    then
      EXISTING_USER=$($PSQL "UPDATE users SET games_played = games_played + 1 WHERE user_id =$DB_USER;")
    elif [[ $DB_USER_BEST_GAME -gt $NUMBER_OF_GUESSES ]]
    then
      EXISTING_RECORD=$($PSQL "UPDATE users SET games_played = games_played + 1, best_game=$NUMBER_OF_GUESSES WHERE user_id=$DB_USER;")
    fi
  else
    NEW_USER=$($PSQL "INSERT INTO users(username, games_played, best_game) VALUES('$USERNAME', 1, $NUMBER_OF_GUESSES);")
  fi
}

echo "Enter your username:"
read USERNAME

if [[ ${#USERNAME} -lt 22 ]]; then
  DB_USER=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")

  if [[ -z "$DB_USER" ]]; then # Added quotes to DB_USER
    echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."
    GUESSING
  else
    ALL_USER_INFO=$($PSQL "SELECT * FROM users WHERE user_id=$DB_USER;")
    echo "$ALL_USER_INFO" | while IFS='|' read USER_ID DB_USERNAME GAMES_PLAYED BEST_GAME; do
    echo -e "Welcome back, $DB_USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
    done
    GUESSING
  fi
else
  echo "Username is too long"
  exit 1
fi


