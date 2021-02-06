# A Lichess Rating Parser

Are you a chess player? If so, you may be familar with an online chess community called Lichess.

# The Steps
Ask the user for the username of the player they want ratings for

'''shell
echo Hello, what Lichess username should I look up?

read varName

echo
echo Here are the ratings for $varName
'''

Download the html file from lichess
'''
curl -s https://lichess.org/@/$varName --output .step1.txt
'''

Grep out the time controls and rating, output the search matches to another file
'''
grep -Po '<span><h3>.+?<\/strong>' .step1.txt > .step2.txt
'''

Isolate the rating controls
'''
grep -Po '(?<=<span><h3>).+?(?=<\/h3>)' .step2.txt > .step3.txt
'''

Isolate the ratings
'''
grep -Po '(?<=<strong>).+?(?=<)' .step2.txt > .step4.txt
'''

Merge the files
'''
pr -m -t .step3.txt .step4.txt > .step5.txt
'''

Display ratings
'''
cat .step5.txt
'''
