#!/bin/bash

PLANSZA=("-" "-" "-" "-" "-" "-" "-" "-" "-")
GRACZ="O"
WYGRANA=false

function wyswietl {
  clear
  echo "Plansza"
  echo "${PLANSZA[0]} | ${PLANSZA[1]} | ${PLANSZA[2]}"
  echo "${PLANSZA[3]} | ${PLANSZA[4]} | ${PLANSZA[5]}"
  echo "${PLANSZA[6]} | ${PLANSZA[7]} | ${PLANSZA[8]}"
}

function sprawdzKombinacje {
  if  [[ ${PLANSZA[$1]} == ${PLANSZA[$2]} ]]&& \
      [[ ${PLANSZA[$2]} == ${PLANSZA[$3]} ]]; then
    WYGRANA=true
  fi
  if [ $WYGRANA == true ]; then
    if [ ${PLANSZA[$1]} == 'O' ];then
      echo "Gracz 1 wygrywa!"
      return 
    else
      echo "Gracz 2 wygrywa!"
      return 
    fi
  fi
}

function sprawdzWygrana {
  if [ ${WYGRANA} == false ]; then return; fi
  sprawdzKombinacje 0 1 2
  if [ ${WYGRANA} == false ]; then return; fi
  sprawdzKombinacje 3 4 5
  if [ ${WYGRANA} == false ]; then return; fi
  sprawdzKombinacje 6 7 8
  if [ ${WYGRANA} == false ]; then return; fi
  sprawdzKombinacje 0 4 8
  if [ ${WYGRANA} == false ]; then return; fi
  sprawdzKombinacje 2 4 6
  if [ ${WYGRANA} == false ]; then return; fi
  sprawdzKombinacje 0 3 6 
  if [ ${WYGRANA} == false ]; then return; fi
  sprawdzKombinacje 1 4 7
  if [ ${WYGRANA} == false ]; then return; fi
  sprawdzKombinacje 2 5 8
  if [ ${WYGRANA} == false ]; then return; fi
}

function zmienGracza {
 if [ $GRACZ = "O" ];
 then
	GRACZ="X"
 else
	GRACZ="O"
 fi 
}

while [ ${WYGRANA} -eq 0 ]
do
  wyswietl
  zmienGracza
  echo -e "\n Które pole zaznaczyć dla zawodnika '${GRACZ}'"
  read POLE

  echo ${POLE}
  if [ "${POLE}" == "" ];
  then
	echo "Złe pole"
	read ZMIENNA
	zmienGracza
	continue
  fi
  echo ${PLANSZA[$POLE]}
  echo $GRACZ
  PLANSZA[$POLE]=$GRACZ
  sprawdzWygrana
done
