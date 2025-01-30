#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
echo -e '\n~~~~~ MY SALON ~~~~~\n'
MAIN_MENU(){
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo -e 'Welcome to My Salon, how can I help you?\n'

  SERVICES=$($PSQL "SELECT service_id, name FROM services;")
  echo "$SERVICES" | while read SERVICE_ID BAR SERVICE_NAME
  do
    echo -e "$SERVICE_ID) $SERVICE_NAME"
  done
  read SERVICE_ID_SELECTED

  # Check if the input is a number
  if [[ ! "$SERVICE_ID_SELECTED" =~ ^[0-9]+$ ]]; then
    MAIN_MENU "Invalid input. Please enter a number."
    return
  fi

    # Correctly validate using cut and grep
  if echo "$SERVICES" | cut -d'|' -f1 | grep -q "^ *${SERVICE_ID_SELECTED} *$" ; then # Added spaces to the grep
    echo -e "\nWhat's your phone number?"
    
    read CUSTOMER_PHONE
    EXISTING_CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'" | xargs)

    #Phone is not registered

    if [[ -z $EXISTING_CUSTOMER_NAME ]]
    then
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME
      NEW_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
      NEW_CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
     
      SERVICE_NAME_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED" | xargs)
      
      echo -e "\nWhat time would you like your $SERVICE_NAME_SELECTED, $CUSTOMER_NAME?"
      read SERVICE_TIME

      NEW_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($NEW_CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
      echo -e "\nI have put you down for a $SERVICE_NAME_SELECTED at $SERVICE_TIME, $CUSTOMER_NAME."
    #phone is registered
    else
      SERVICE_NAME_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED" | xargs)
      
      echo -e "\nWhat time would you like your $SERVICE_NAME_SELECTED, $EXISTING_CUSTOMER_NAME?"
      read SERVICE_TIME

      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

      NEW_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

      echo -e "\nI have put you down for a $SERVICE_NAME_SELECTED at $SERVICE_TIME, $EXISTING_CUSTOMER_NAME."
    fi
  else
    MAIN_MENU "I could not find that service. What would you like today?"
    return
  fi
}
MAIN_MENU