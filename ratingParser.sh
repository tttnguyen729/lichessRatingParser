#!/bin/bash
# Ask the user for the username of the player they want ratings for

echo Hello, what Lichess username should I look up?
echo Enter quit to exit the program.

read varName


while [ $varName != quit ]
do
	
echo 
echo Here are the ratings for $varName

# Download the html file from lichess
# The s flag makes curl run the operation silently
curl -s https://lichess.org/@/$varName --output .step1.txt

# Grep out the time controls and rating, output the search matches to another file
grep -Po '<span><h3>.+?<\/strong>' .step1.txt > .step2.txt

# Isolate the rating controls
grep -Po '(?<=<span><h3>).+?(?=<\/h3>)' .step2.txt > .step3.txt

# Isolate the ratings
grep -Po '(?<=<strong>).+?(?=<)' .step2.txt > .step4.txt

# Merge the files
pr -m -t .step3.txt .step4.txt > .step5.txt

# Display ratings
cat .step5.txt

# Asking for next username
echo 
echo What is the next Lichess username I should look up?
echo Enter "quit" to exit the program.

read varName

done
echo 
echo Goodbye!
