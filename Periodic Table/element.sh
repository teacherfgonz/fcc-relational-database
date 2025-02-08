PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
if [[ -z $1 ]]
then
  echo 'Please provide an element as an argument.'
else
  # Find by atomic number
  if [[ $1 =~ [0-9]+ ]]
  then
    ELEMENT=$($PSQL "SELECT * FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$1;") #fixed the error of p_atomic_number
    if [[ -z $ELEMENT ]]
    then
      echo "I could not find that element in the database."
    elif [[ $ELEMENT ]]
    then
      echo "$ELEMENT" | while read TYPE_ID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS BAR TYPE
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
      done
    fi
  #Find by symbol
  elif [[ $1 =~ ^[A-Z][a-z]?$ ]]
  then
    ELEMENT=$($PSQL "SELECT * FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol='$1';")
    if [[ -z $ELEMENT ]]
    then
        echo "I could not find that element in the database."
    elif [[ $ELEMENT ]]
    then
      echo "$ELEMENT" | while read TYPE_ID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS BAR TYPE
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
      done
    fi
  #find by name
  elif [[ $1 =~ ^[A-Z][a-z]*$ ]]
  then
    ELEMENT=$($PSQL "SELECT * FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE name='$1';")
    if [[ -z $ELEMENT ]]
    then
      echo "I could not find that element in the database."
    elif [[ $ELEMENT ]]
    then
      echo "$ELEMENT" | while read TYPE_ID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS BAR TYPE
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
      done
    fi
  else # this else is for the first if, if the input is not empty or a number of a name
    echo "I could not find that element in the database."
  fi
fi