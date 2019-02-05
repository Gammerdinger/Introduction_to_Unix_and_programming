#!/bin/bash
# These are some loop examples

echo -e "Example 1\n"

for i in 1 2 3 4 5; do
    echo $i
done

echo -e "\nExample 2\n"

for i in {1..5}; do
  echo $i
done

echo -e "\nExample 3\n"

for i in {1..5}; do echo $i; done

echo -e "\nExample 4\n"

for i in {1..5}; do
  for j in {1..4}; do
    echo -e "$i\t$j"
  done
done

echo -e "\nExample 5\n"

for i in {1..5}; do
    echo $i
    if [[ "$i" -lt 4 ]]; then
       echo "$i is less than 4"
    fi
done

echo -e "\nExample 6\n"

for i in {1..5}; do
    echo $i
    if [[ "$i" -ge 2 && "$i" -lt 4  ]]; then
	echo "$i is greater than or equal to 2 and less than 4"
    fi
done

echo -e "\nExample 7\n"

for i in {1..5}; do
    echo $i
    if [[ "$i" -ge 2 ]]; then
	if [[ "$i" -lt 4 ]]; then
	  echo "$i is greater than or equal to 2 and less than 4"
	fi  
    fi
done

echo -e "\nExample 8\n"

for i in {1..5}; do
    echo $i
    if [[ "$i" -le 2 || "$i" -gt 4 ]]; then
       echo "$i is either less than or equal to 2 or greater than 4"
    fi
done

echo -e "\nExample 9\n"

for i in {1..5}; do
    echo $i
    if [[ "$i" -lt 4 ]]; then
	echo "$i is less than 4"
    else
	echo "$i is greater than or equal to 4"
    fi
done

echo -e "\nExample 10\n"

for i in {1..5}; do
    echo $i
    if [[ "$i" -lt 3 ]]; then
	echo "$i is less than 3"
    elif [[ "$i" -eq 4 ]]; then
	echo "$i is equal to 4"
    else
	echo "$i is not less than 3 or equal to 4"
    fi
done

echo -e "\nExample 11\n"

i=10
until [[ "$i" -le 5 ]]; do
    echo "$i is not less than of equal to 5"
    i=$(echo "$i - 1" | bc -l )
done

echo -e "\nExample 12\n"

i=0
while [[ "$i" -lt 5 ]]; do
  echo "$i is less than 5"
  i=$(($i+1))
done

echo -e "\nExample 13\n"

while read animal noise; do
  echo "The $animal goes $noise."
done < animal_noises.txt

echo -e "\nExample 14\n"

while read animal noise; do
  if [[ "$animal" == "Cow" ]]; then
    echo "The $animal goes $noise."
  fi
done < animal_noises.txt

echo -e "\nExample 15\n"

while read animal noise; do
  if [[ "$animal" =~ e$ ]]; then
    echo "The $animal goes $noise."
  fi
done < animal_noises.txt

echo -e "\nExample 16\n"

declare -a animal_array=( "Cow" "Pig" "Chicken" "Dog" )

for animal in "${animal_array[@]}"; do 
  echo $animal
done

echo -e "\nExample 17\n"

declare -A animal_noises_associative_array_2

while read animal noises; do
    animal_noises_associative_array_2[$animal]=$noises
done < animal_noises.txt

echo -e "The pig goes ${animal_noises_associative_array_2[Pig]}."
echo -e "The chicken goes ${animal_noises_associative_array_2[Chicken]}"
echo -e "The rooster goes ${animal_noises_associative_array_2[Rooster]}"