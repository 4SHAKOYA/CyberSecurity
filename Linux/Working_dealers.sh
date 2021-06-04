echo -e "LineNo\tMonth\tDate\tTime\tAM-PM\tDealer" > Roulette_Losses
grep -E '05:00:00 AM|08:00:00 AM|02:00:00 PM|08:00:00 PM|11:00:00 PM' 0310_Dealer_schedule | awk -F ' ' '{print NR"\t"03"\t"10"\t"$1"\t"$2"\t"$5"\t"$6}' >> Roulette_Losses
grep -E '05:00:00 AM|08:00:00 AM|02:00:00 PM|08:00:00 PM|11:00:00 PM' 0312_Dealer_schedule | awk -F ' ' '{print NR"\t"03"\t"12"\t"$1"\t"$2"\t"$5"\t"$6}' >> Roulette_Losses
grep -E '05:00:00 AM|08:00:00 AM|02:00:00 PM' 0315_Dealer_schedule | awk -F ' ' '{print NR"\t"03"\t"15"\t"$1"\t"$2"\t"$5"\t"$6}' >> Roulette_Losses

