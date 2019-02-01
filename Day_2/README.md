Now you have a foundation for navigating around the Unix hierarchy. Let's move onto a few odds and ends along with file manipulation.

# Day 2: Odds and Ends along with Regular Expressions and File Manipulation

## Wildcard Characters

Let's imagine you want to do a use `cat`/`head`/`tail`/etc. over every file that ends in `.txt`. Now, as you have previously seen, you could do something like:

`cat file_1.txt file_2.txt file_3.txt file_4.txt file_5.txt file_6.txt file_7.txt file_8.txt file_9.txt file_10.txt file_11.txt file_12.txt file_21.txt turkey.txt goose.txt ist.txt`

But as you can see that can be tedious especially if you have many files. Instead you might hope for some type of shortcut and that is what wildcard characters are for. If the above example represented all of the `.txt` files in your folder and you wanted to `cat` them all, then you could simply write:

`cat *.txt`

The `*` symbol is stands in for any number of any characters (including a length of 0 characters).

You can also place the `*` in between strings of characters. In the previous example, you might have wanted to only `cat` files that start with `file_` and end in `.txt`. You could accomplish this by using:

`cat file_*.txt`

You may like the wildcard aspect of `*`, but you want to limit the number of characters. This is where `?` comes in. Using `?` represents any *single* character. In the previous example, if you only wanted to `cat` the files that started with `file_` and ended in `.txt` **AND** with only a **SINGLE** character between those two strings, then you could use:

`cat file_?.txt`

You can also put multiple `?` together. If you want to cat all of the files will **TWO** characters between `file_` and `.txt`, then you could use:

`file_??.txt`

Wildcards are immensely useful and can really save you a bunch of time.

## echo

# For various reasons you may want to have the command line return back a given string or variable
# The echo command does just that
# It can also be helpful for figuring out where your home is or what is in your path
# If you want the command line to return a string of characters, you can try:

echo string

# On its surface you, echo might not appear super helpful since you are already typing it once, but it can be very helpful, particularly with loops that we will learn about later
# Also, now is a good place to talk about new lines and tabs
# To my knowledge, all languages (I'm sure there are exceptions, but bash, awk, Perl and I think Python all code it this way) code tabs and new lines in the same way
# If you want to see a tab you need to use \t and if you want a new line you will need to use \n
# I am telling you this now because you should learn the -e option for echo
# The -e option will allow the interpretation of the escape character \
# However, to use it, you will need to put your string in quotes, like:

echo -e "Separated\tby\ttabs\nnewline"

# The use of \t and \n is going to be very useful at points moving forward, particulary when you write software in bash

# Another great use of echo is for determining some environmental variables
# As I noted earlier, it can be helpful to determine where your home directory is using:

echo $HOME

# We have not talked about variables yet, but $HOME is a special type of variable referred to as a environmental variable
# Environmental variables control certain aspects of your Unix environment, like where your home directory is set to

# There is likely one of environmental variables you should be aware of is $PATH
# When you call any software, from cat to some specific software package you are using for your research, your computer will use this $PATH variable
# Your computer will look in every directory in $PATH looking for the software package that you are calling
# You can figure out which directories it will look in by:

echo $PATH

# Each directory that your computer will look in is separated by a :
# If your called software package is not found in that path, it will not run.
# When we talk about variables, I plan talk about how to add a path to this environmental variable

############ touch ########

# You might want to make an empty file or update the time a file was last used
# Both of these tasks can be accomplished with touch
# I personally don't use touch very much, but here are the two uses and the second one has some minor ethical considerations attached to it
# If you would like to make an empty file, simply call the touch command followed by the desired file name, like

touch new_file.txt

# I think the main reason people use touch is a bit more dubious, but can be justified at times
# Many high performance computer clusters have a large amount of space set aside for storing files.
# However, as computer clusters fill up, system administators often started asking people to delete old files since many of these clusters are not set up as long term archives
# And generally speaking, I think people make a reasonable attempt to comply
# However, eventually the cluster fills up and system administrators need to develop a method for deleting files that are no longer being used anymore
# An easy way to implement this policy is to look at the time the file was last opened
# Policies vary from cluster to cluster with some deleting things that are more than 6 months old to some that delete things that are 14 days old
# Anyways, as you can see the time a file was last accessed can be important if your data is on a computer cluster
# This is a job that touch can help with
# You can design (or easily find on Google) a command that will touch every file recursively and you run it periodically to make sure that system administrators never delete your data
# However, I think this is against the spirit of these policies, so I wont teach this to you
# However, what these policies get wrong is that some old files are always important
# Perhaps the old file is a reference genome sequence or your raw data that you are working from
# Thus, you can simply touch the file and it will create a fresh timestamp by calling the touch command followed by the filename like:

touch file_with_old_timestamp.txt

######### wc #######

# Imagine that you want to know how many lines or characters are in a file
# This is the role of the wc command, whch stands for Word Count
# It will tell you how many lines, words and bytes are in a file or string that it is run on in the first, second and third columns resepctively
# Generally, speaking the number of bytes is usually similar to the number of characters, but there is a subtle difference since there are multibyte characters depending on the encoding
# If you want to know the number of characters, use the option I discuss below in a bit
# If you run it on our hello_world.txt file that had "Hello world!!!" in it, then it would look like

wc hello_world.txt

# It would tell us that there is one line, two words and 15 bytes.
# I never use wc without options and I think the overwhlemingly most useful option for my research with wc is the -l option which will just return the number of lines in the file

wc -l hello_world.txt

# Should return just one unless you have an extra return in the file

# The -w option will return the number of words

wc -w hello_world.txt

# This should return two

# The -m option will return the number of characters

wc -m hello_world.txt

# This should be 15
# You might count the character up and say there are only 14 characters in the file
# However, the difference is that the new line character (while not seen) also counts as a character thus brings the total to 15

######### ln -s ########

# You might have a situation where you have a large file somewhere that you would like to use, but for some reason the software you are running needs a copy in a specific place
# To solve this we are going to use a specific option -s with the ln command to make what is called a symbolic link
# You can use the ln command without the -s option and it makes a hard link
# Hard links contain the data in the linked file, while using the -s option makes a symbolic link which simply points to the file or directory in question
# I think most people use the -s option when running the ln command
# In fact, I had to look up what hard links were because I have never heard of them before writing this
# Anyways, so you have a big file in /homes/thin/really_big_file.txt and you have a software program that needs a copy in its folder /homes/thin/stupid_software/link_to_really_big_file
# You can make a symbolic link by calling the ln command with -s option followed by the file you want to make a link of and then followed by the location and name of the link, like

ln -s /homes/thin/really_big_file.txt /homes/thin/stupid_software/link_to_really_big_file

# Note it you run ls -l it will show you the link and point using -> the original file using a relative path
# Also, SUPER IMPORTANT, if you use the mv command on linked file the the link is broken and will not work
# In this case you will need to delete the link and re-establish it

######### md5sum #########

# Perhaps you made a file and you want to make sure that it is the same as a previous file you made
# The md5sum command will be helpful to you
# The md5sum takes the data from a file and turns it into a non-unique hash
# This means that the resulting output can be reached from various ways, but realistically, if you suspect the files are the same and the md5sums are equivalent, you are safe to assume that the files are equivalent
# To run the md5sum command you just need to call the md5sum command followed by the name of the file, like

md5sum hello_world.txt

# This returns the hash 032447899e6c18dd3e30388764c0ff21
# Any small deviation in characters will almost assuredly (my understanding is that it is theorectically possible but practically impossible for this not to occur) change the md5sum
# Many people like md5sums to ensure that a file is the same before and after a transfer or make sure they had replicated their work

######## sed and basic handling of regular expressions ########

# Maybe you have a file, but you would like to edit it in some systematic manner
# Perhaps you want to replace the a symbol/word/character with something else
# This can be accomplished with the sed command, which stands for Stream EDiting
# sed is EXTREMELY powerful and can handle regular expressions
# What I am going to show you is only a fraction of what sed can do, but it is what I personally use sed for the most
# The syntax for sed is geneally like:

sed 's/old_text/next_text/g' file.txt

# The s in the front signifies that you wish to make a Substitution
# There are many other letters that can go here to do different things, but I think s for substituting is probably the most common
# The g at the end denotes that you want the substitution to occur Globally (everywhere), otherwise it will just change the first occurrence 
# I think most the the time this global situation is what you want
# However, if you don't want this, just leave off the g and at it will just replace the first occurence

# As I mention, sed can handle regular expressions and they can be quite powerful
# One nifty trick with regular expressions is that if you want to demand the that target string starts a line, you can put ^ in front of it, like:

sed 's/^old_text/next_text/g' file.txt

# Another nifty version of this is to place a $ at the end of the string and this will replace only this string if it is at the end of a line, like:

sed 's/old_text$/next_text/g' file.txt

# Another thing you should know about regular expressions is that . matches any single symbol
# Following our previous example, if you didn't care what the e was in old_text you could do the following:

sed 's/old_t.xt/next_text/g' file.txt

# If you wanted to limit the letters that could be in the place that currently has e with you could use square brackets
# For example, you old want the substitution to occur if there is a vowel in that position, then you could use:

sed 's/old_t[aeiou]xt/next_text/g' file.txt

# You could also say that you only cared that it was a lower case letter from a to p
# You could type out every letter from a to p, or you could just do this:

sed 's/old_t[a-p]xt/next_text/g' file.txt

# You could even say that you want any (including 0) number of letters matching a-p by combining the square brackets with an asterisk like:

sed 's/old_t[a-p]*xt/next_text/g' file.txt

# You can also say that you want to match upper case letters from A to P instead of lowercase letters in that position like:

sed 's/old_t[A-P]xt/next_text/g' file.txt

# You can even match numbers 0-7 in that position like:

sed 's/old_t[0-7]xt/next_text/g' file.txt

# You can try matching multiple patterns like all lowercase letters from a to z or all uppercase letters from A to Z using the | to separate the different acceptable matches

sed 's/old_t[a-z|A-Z]xt/next_text/g' file.txt

# Lastly, you can choose not to replace it with anything and it will just delete the match using:

sed 's/old_text//g' file.txt

# As I have said, there are many more parts to sed but this is one of the most common uses
# Furthermore, there are so many things that you can do with regular expressions, that an expert could probably show you things all day long
# If you want to learn more regular expression syntax there are lots of resources online and there are people who are REALLY amazing at them
# What I have shown you is pretty close the limits of my knowledge with regular expressions, but there are people that really are wizards when it comes to using them
# While this primer to regular expressions is not exhaustive, it will likely give you a sufficient introduction to them for most situations

######### awk ########

# When you are dealing with columns, awk is likely your friend
# awk is its own programming language and is EXTREMELY useful
# A small sidenote, most systems actually use gawk which is a later version of awk, but I think most of the people I talk to still call it awk since the awk command still works
# However, my awk knowledge is limited to a useful subset of what awk can do
# If your problem has anything to do with columns, I can assure you that awk is almost certainly part of your solution

# The first thing you should probably know is how to print a column
# In this case let us play like you wanted to print out the second column from a file, then you would use:

awk '{print $2}' file.txt

# The number after the dollar sign signifies the column, whith the first column being 1
# So in this case, the 2 signifies the second column in the file you want to print out
# A small note is that $0 refers to the whole line
# You can also print multiple columns by separating the columns with a space like:

awk '{print $2,$3}' file.txt

# The file format that uses tabs to separate columns is called tab-delimited format and is widely used 
# Oftentimes spaces are fine, but sometimes they are handled strangley, so it is probably best practice to use tabs
# Once again, we are going to briefly talk about variables
# There are many defaults in awk and one of them is called the OFS, which stands for output field separator
# If you want to alter how the columns are separated in your output you are going to want to alter this variable
# To be able to alter variables in awk you need to use the -v option, then you need to specify which variable you are interested in altering
# In this case we want to alter the OFS variable and set it equal to tab, which remember is \t
# To do this, the syntax would be:

awk -v OFS='\t' '{print $2,$3}' file.txt

# Alternatively, you could also accomplish this by using:

awk '{print $2"\t"$3}' file.txt

# However this isn't nearly as elegant

# Of course you could set the OFS to anything you'd like from a random string of letters to even a new line using \n

# The last thing we are going to talk about with awk today is using regular expressions to match in awk
# Let's say you wanted the rows from a file when the third column matched some pattern
# You could combine regular expressions with awk to accomplish this like:

awk '$3 ~ /regular_expression_pattern/' file.txt

# You could also grab lines that don't match this pattern in the third column by saying:

awk '$3 !~ /regular_expression_pattern/' file.txt

# You could search for multiple patterns in different columns by separating the patterns by && like:

awk '$3 ~ /regular_expression_pattern/ && $4 ~ /other_regular_expression_pattern/' file.txt

# Alternatively you could ask if a pattern matches in either of multiple columns and separating the conditions by ||

awk '$3 ~ /regular_expression_pattern/ || $4 ~ /other_regular_expression_pattern/' file.txt

# You could even then go ahead and print the first and second columns of a file (separated by a tab) when the third column does not match some pattern like:

awk -v OFS='\t' '$3 !~ /regular_expression_pattern/ {print $1, $2}' file.txt

# I hope that this have given you an appreciation for awk, but also regular expressions and how powerful both can be
# We are going to come back to awk next class and talk about more doing math with awk (like finding the average of a column or dividing two columns be each other)

######### grep ########

# If you are looking for the search engine of the unix environment, grep is your friend
# grep is very fast at searching files for specific patterns and can handle a wide range of problems
# Between awk and grep, most of your file parsing can be achieved
# The basic syntax is calling grep followed by your search pattern in single quotes then the file like:

grep 'pattern' file.txt

# Once disadvantage to grep is that the default is will print out a match if it finds it anywhere
# What I mean by that is if you search for 'out', grep will find ALL matches contain 'out' in them, like 'out', 'outer', 'about', etc.
# One easy way to solve this is to use the -w option
# The -w option forces grep to only find matches that match full words like:

grep -w 'pattern' file.txt

# Now if we searched out we would only get results for 'out' if it was preceded and followed by non-word consitituents (like new lines and white space)
# A flavor of this same idea idea is that your pattern has to match the full line and this uses the -x option like:

grep -x 'full_line_pattern' file.txt

# This acts just as though you have a ^ at the beginning of the pattern and a $ at the end of the pattern
# Which is convienent that I should mention, because, yes, grep can also recognize regular expressions
# So if you wanted to grep lines that that started with letter A through G, you could do:

grep '^[A-G]' file.txt

# If you want to search for multiple criteria and only one needs to pass then you need to use the -e option for each search criteria
# So, if you wanted to grep lines that that started with letter A through G or P through Y, you could do:

grep -e '^[A-G]' -e '^[P-Y]' file.txt

# If you want to know how many lines are outputed from a grep result you can use the -c option like:

grep -c 'pattern' file.txt

# So far I have shown you lots of things you can do in awk if you have a tab-delimited file format, but two nice grep options are -A and -B 
# The -A option will print out the number of lines specified after a match
# For example if you want the matching line along with the two lines after it you can use:

grep -A 2 'pattern' file.txt

# The 2 here specifies the number of lines after the match you want printed out
# The -B is the exact same but prints out the number of line before the match like

grep -B 3 'pattern' file.txt

# This will print the three lines before the match

# The only caution to have with these two options if that they will clump contiguous results together with -- between the groups
# In other words, in the -A example, if the next match comes within two lines of the first hit they just group them all together and put a -- between them
# Sometimes, this isn't a problem, but sometimes it is less than ideal

######### Pipes #######

# Now we are going to really start cooking and we will learn how to feed the output from one command into the input of another
# This can be down with what is called a pipe, which is symbolized by a |
# Let's say you want to take the output from a grep search and then use sed to edit it
# That could be done like:

grep 'pattern' file.txt | sed 's/old_pattern/new_pattern/g'

# Note that the parsed file that we are passing to the second command does not need to be opened again in the second command
# This parsed file is considered the standard input, or stdin, for the second command and it the standard out, or stdout of the first command

# Perhaps we wanted to know how many lines match a given pattern in column 3 of your file, then you can do:

awk '$3 ~ /regular_expression_pattern/' file.txt | wc -l

# Pipes might be one of the most powerful things you can do in Unix, because it lets you harness the strengths of different commands
# The possiblities that you can do with pipes is really quite limitless
# Some people take quite a bit of pride in writing a long line of code connected by many pipes that parses a file dozens of different ways to get the desired output
# While any single continuous line of code is considered a "one-liner", these long lines connected by many pipes are usually pretty interesting and impressive

######### Writing output to a file ########

# Now you have learn how to parse lots of things, you probably want to know how to write your output to a new file
# This is where > comes in
# > allows you to feed output into a new file
# Let's imagine that you want to feed the output from a grep to a new file
# The syntax for that would look like:

grep 'pattern' file.txt > grep_hits.txt

# The file grep_hits.txt now contains the output from your grep search
# Note that this will, depending on the defaults of the system you are working in, overwrite any previous files with that name

# If instead you don't want to write a new file, but rather append something to the end of a new file, you can use >> instead of >
# If you wanted to append something to the end of a file, then the syntax for something like this would look like:

grep 'pattern_2' grep_hits.txt >> appended_grep_hits.txt

######### sort ########

# In order to use certain software packages or commands, such as uniq, files need to be sorted
# This can be accomplished with the sort command
# Generally speaking, it sorts things alphetically, but there are a few quirks you should be aware of.
# The general syntax is calling the sort command followed by the file that you wish to sort like:

sort file.txt

# The -r option in sort does the sort in reverse alphabetical order

sort -r file.txt

# If you want to sort numbers then you need to use the -n option
# If you dont, it will sort the output as 1, 10, 11, 100, 2, 20, 21, 22, 3 ...

sort -n file.txt

# If you have a mix of numbers and letters in a string, you probably want to do a "natural sort" which is the -V option
# If you had say scaffold1, scaffold2 and scaffold10 in a file, then sort would order them like scaffold1, scaffold10 and scaffold2, but a natural sort would get you scaffold1, scaffold2 and scaffold10
# The syntax is:

sort -V file.txt

# Also, you might want to sort a file by a certain column
# The -k option allows you to pick the column to wish to sort by and can be used like:

sort -k2 file.txt

# If two items are the same in column 2 it goes onto column 3 to sort them, so on and so forth unto the end of the line or they are resolved
# However, you can set the limits of this by adding a comma and limit the column
# This is needed if you want to sort by different columns or sorting regimes
# For example if you want to sort the second column of a file alphabetically and the third column reverse numerically you would need to use:

sort -k2,2 -nrk3,3 file.txt

########## uniq #########

# Lastly, you might want to only want the unique entries for a file
# This is where the uniq command comes in
# However, for uniq to work, the file needs to be sorted previously, so we will do this with a pipe like:

sort file.txt | uniq

# This will return all of our unique entries in our file

# The -c option is nice because it tells you how many counts occured for each entry
# The syntax would looke like:

sort file.txt | uniq -c

# The output has the number of counts in the file for each unique entry in the first column and what the unique entry is in the second column
