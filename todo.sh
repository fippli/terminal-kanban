#!/bin/bash

function mainMenu() {
  printf "\n\n"
  ./tableHead.sh
  readTasks

  echo "    + - - - - - - - - - - - - - - - - - - - - - - - - -+- - - - - - - - - - - - - - - - - - - - - - - - - - - - + - - - - - - - - - - - - - - - - - - - - - - - - +"
  read -p  "    | [A]DD TASK / [D]ELETE TASK / [M]OVE TASK / [Q]UIT : " CHOICE

  if [[ ${CHOICE} == "a" ]]; then
    addTask
  fi

  if [[ ${CHOICE} == "d" ]]; then
    deleteTask
  fi

  if [[ ${CHOICE} == "m" ]]; then
    moveTask
  fi
}

function moveTask() {
  echo "    | SELECT BOARD TO MOVE FROM:"
  READ_FILE=$(selectBoard)
  read -p "    | SELECT TASK TO MOVE: " MOVE_TASK
  echo "    | SELECT BOARD TO MOVE TO:"
  WRITE_FILE=$(selectBoard)

  #Read the line
  MOVE_LINE=$( sed "${MOVE_TASK}q;d" ${READ_FILE} )
  #Write the line
  echo ${MOVE_LINE} >> ${WRITE_FILE}
  #Delete the line
  sed -i.bak "${MOVE_TASK}d" ${READ_FILE}
}

function addTask() {
  read -p "    | ENTER NEW TASK: " TASK
  echo ${TASK} >> todo.txt
}

function readTasks() {
  # Count the lines ins the file
  LINES=$( wc -l < ./todo.txt )
  i=0
  while [[ $i -lt $((LINES)) ]]; do
    i=$((i+1))
    printf "%-54s %-56s %-49s %-s\n" "    |" "|" "|" "|"
    printf "%-55s" "    | [${i}] $( sed "${i}q;d" ./todo.txt )"
    doing="$( sed "${i}q;d" ./doing.txt )"
    if [[ $doing != "" ]]; then
      printf "%-57s" "    | [${i}] ${doing}"
    else
      printf "%-57s" "|"
    fi
    tdone="$( sed "${i}q;d" ./done.txt )"
    if [[ $tdone != "" ]]; then
      printf "%-50s" "    | [${i}] ${tdone}"
    else
      printf "%-50s" "|"
    fi
    printf "%s\n" "|"
  done
  printf "%-54s %-56s %-49s %-s\n" "    |" "|" "|" "|"
}

function deleteTask() {
  echo "    | SELECT BOARD TO DELETE FROM:"
  DEL_FILE=$(selectBoard)
  read -p "    | SELECT TASK TO DELETE: " DEL
  sed -i.bak "${DEL}d" ${DEL_FILE}
}

function selectBoard() {
  read -p "    | [1] TODO / [2] DOING / [3] DONE : " BOARD
  BOARDS[1]="./todo.txt"
  BOARDS[2]="./doing.txt"
  BOARDS[3]="./done.txt"
  echo "${BOARDS[${BOARD}]}"
}

function main() {
  while [[ ${CHOICE} != "q" ]]; do
    mainMenu
  done
  cd ${1}
}

main
