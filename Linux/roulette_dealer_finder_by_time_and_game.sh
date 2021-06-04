# ------------ SCRIPT ------------- #

#!/bin/bash


#echo -n "Enter the date (or part of) you want to review (MMDD): "
#read ARG1
#echo -n "Enter the time (or part of) you want to review (HH:MM:SS): "
#read ARG2
#echo -n "Enter AM or PM for the time you want to review (AM or PM): "
#read ARG3
#echo -n "Enter the Dealer Position [0-3] (0=All,1=Blackjack,2=Roulette, 3=Texas Hold'em): "
#read ARG4


if [ $# -lt 3 ]; then
  echo 1>&2 "$0: not enough arguments"
  echo "Command Line Usage: ${0} [MONTH_DATE(MMDD)] [TIME(HH:MM)] [AMPM] [optional DEALER POSITION[0-3](0=All,1=Blackjack,2=Roulette, 3=Texas Hold'em)]"
  echo "e.g. ${0} 0315 08:00 AM 1 would be March 15th at 8am for the Blackjack Dealer's Name"
  exit 2
elif [ $# -gt 4 ]; then
  echo 1>&2 "$0: there are too many arguments in the command line"
  echo "Command Line Usage: ${0} [MONTH_DATE(MMDD)] [TIME(HH:MM)] [AMPM] [optional DEALER POSITION[0-3](0=All,1=Blackjack,2=Roulette, 3=Texas Hold'em)]"
  echo "e.g. ${0} 0315 08:00 AM 1 would be March 15th at 8am for the Blackjack Dealer's Name"
  exit 2
fi

ARG1=$1
ARG2=$2
ARG3=$3
ARG4=${4:-0}

if [ $ARG4 -gt 3 ]; then 
  echo "Changing ARG4 to 0 as passed argument ("$ARG4") was greater than 3"
  ARG4=0 
fi

echo "Passed arguments: "$ARG1", "$ARG2", "$ARG3", "$ARG4
#Exit code 0=Success
#Exit code 1=General Errors
#Exit code 2=Misuse of Command Line

#echo "Alling awk command to build the temporary data file"
awk -F ' ' '{print substr(FILENAME,1,4)"\t"$1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8}' *Dealer_schedule > tempdata

# -- code I could not get working
#
#echo "grep -E -i '$1.*$2.*$3' tempdata"
#grep -E -i '$1.*$2.*$3' tempdata >tempdata1
#

#echo  "grep -i $ARG1 tempdata > tempdata1"
grep -i $ARG1 tempdata >tempdata1
rm tempdata

#echo "grep -i $ARG2 tempdata1 > tempdata2"
grep -i $ARG2 tempdata1 > tempdata2
rm tempdata1

#echo "grep -i $ARG3 tempdata2 >tempdata3"
grep -i $ARG3 tempdata2 >tempdata3
rm tempdata2


case $ARG4 in
  1)
  awk 'BEGIN {FS="\t"};{ print "            Month: "substr($1,1,2)
                         print "              Day: "substr($1,3,2)
                         print "             Time: "$2" "$3
                         print "Black Jack Dealer: "$4" "$5
                         print "---------------------------------------"}' tempdata3 >finaldata
  ;;
  2)
  awk 'BEGIN {FS="\t"};{ print "            Month: "substr($1,1,2)
                         print "              Day: "substr($1,3,2)
                         print "             Time: "$2" "$3
                         print "  Roulette Dealer: "$6" "$7
                         print "---------------------------------------"}' tempdata3 >finaldata
  ;;
  3)
  awk 'BEGIN {FS="\t"};{ print "            Month: "substr($1,1,2)
                         print "              Day: "substr($1,3,2)
                         print "             Time: "$2" "$3
                         print "     Poker Dealer: "$8" "$9
                         print "---------------------------------------"}' tempdata3 >finaldata
  ;;
  *)
  awk 'BEGIN {FS="\t"};{ print "            Month: "substr($1,1,2)
                         print "              Day: "substr($1,3,2)
                         print "             Time: "$2" "$3
                         print "Black Jack Dealer: "$4" "$5
                         print "  Roulette Dealer: "$6" "$7
                         print "     Poker Dealer: "$8" "$9
                         print "---------------------------------------"}' tempdata3 >finaldata
  ;;
esac


rm tempdata3
cat finaldata

echo "A text file called 'finaldata' was created in the current directory for you review"

# cat $1_Dealer_schedule | awk -F" " '{print $1, $2, '$3','$4' }'| grep "$2"
exit

# ------------- END SCRIPT ------------

