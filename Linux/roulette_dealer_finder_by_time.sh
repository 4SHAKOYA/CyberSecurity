#! /bin/bash

#input the date(MMDD) and time (HHMM) and output the time and dealer
grep -w "$2 $3"  $1_Dealer_schedule | awk -F" " '{print $1, $2, $5, $6}' 
