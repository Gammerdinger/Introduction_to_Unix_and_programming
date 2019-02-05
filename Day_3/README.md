Today we are going to probe into a little more depth with a few commands and also introduce the fundamentals of programming. In this exercise, we are going to focus on programming using `bash`, which is a common shell for the Unix environment. I do hesitate to teach you all very much `bash` because it is ***VERY*** finicky when it some to proper syntax and programming languages like Perl and Python are ***MUCH*** more forgiving. However, you may want/need to use it is some cases and most programming languages are largely similiar in capabilities for beginners. That being said, moving forward after this course, I would encourage you to learn Perl or Python for most of your programming needs (probably Python is the better choice, but a dying breed of programmers including myself use Perl). However, in order to introduce Perl (or likely Python for that matter), I would need to introduce you to some idiosyncrasies of these languages.

Before we get started we need to install `bc` on the computers. It is usually on most Unix systems, but for some reason it is not on these computers. In order to dowload and install this, type:

`sudo apt install bc`

# Variables

We have discussed variables enough that I should tell you what they are and how to assign them. Variables are a type of data architecture that can hold a string or value. In Bash, which is the shell of Unix that we are focusing on, the syntax looks like:

`some_variable=some_string_or_value`

When calling a vairable, you must place a dollar sign in front of the variable in `bash` (This notation is not universal in programming languages). Now, if you would like to see what that variable represents, you simply need to use echo like:

`echo $some_variable`

This should return:

`some_string_or_value`

You can overwrite variables the same way as using them the first time like:

`some_variable=some_other_string_or_value`

Now `echo $some_variable`, should return:

`some_other_string_or_value`

In most programming languages, doing math is usually very straightforward, but `bash` is not very good for it. It is particularly poor for decimals. I will show you an example of the safest way to do math in `bash`, but you should be aware that in general, it is a bit cumbersome and clunky to do math in `bash`.

In order to add numbers, you need to first `echo` both numbers with the sign you'd like to use in between them (`+` for addition, `-` for subtraction, `*` for multiplication, `/` for divide, `^` for exponents) in double quotes followed by a pipe to the `bc` command with the `-l` option.  For example if you wanted to do 2 plus 3, the best practice for achieving this would be something like:

`echo "2 + 3" | bc -l`

This would return:

`5`

You can more also add variables. First, set your variables:

`num_1=4`

`num_2=5`

`echo "$num_1 + num_2" | bc -l`

You can try the other operations as well:

```
echo "$num_1 - num_2" | bc -l
echo "$num_1 * num_2" | bc -l
echo "$num_1 / num_2" | bc -l
echo "$num_1 ^ num_2" | bc -l
```

Now, you might be interested in setting this output equal to a new variable and this is where the syntax really gets clunky. For the scope of this course, I think you can just follow this example, but explaining the syntax is near the boundaries of my understanding. The syntax for this situation is:

`new_variable=$(echo "$num_1 + num_2" | bc -l)`

And you can check it using:

`echo $new_variable`

We talked about the `$PATH` enivronmental variable last time. You can also add a path (in this case `/new/thing/added/to/path` to your `$PATH` environmental variable, by using:

`PATH=$PATH:/new/thing/added/to/path`

The `$PATH:` simply means that you want to keep the old set of paths, but now add an additional path to it.

You could also change your home directory (to `/new/home/directory`) like:

`HOME=/new/home/directory`

# Advanced awk

Last class, you saw how powerful `awk` could be of working with columns, particularly with regular expressions. `awk` is also very powerful for doing math, particularly between columns. Let imagine that you have a file, named file.txt, and you want to substract the second column from the first column. Then you could do something like:

`awk '{print $1 - $2}' file.txt`

You can also make variables in `awk`. For example, if you had a file named file.txt and wanted to substract the second column from the first column and assign it to a new column (we will call in $3), then print the variable you could:

`awk '$3 = $1 - $2 {print $3}' file.txt`

If you wanted to print the whole line with your new column, you can simply just say:

`awk '$3 = $1 - $2 {print $0}' file.txt`

Remember that `$0` represents the whole line.

Two interesting special variables in `awk` are the `NF` and `NR` variables which stand for number of fields (or columns) and number of records, respecively. `NF` is not usually the most useful, because many files have the same number of columns in each row, but if you wanted to see how many columns are in each row you could print the `NF` option after the each row like:

`awk '{print $0, $NF}' file.txt`

A really important and useful special variable in `awk` is `NR`. This will count in an ascending order the number of rows (or records) in the file. You can see this by using:

`awk '{print $0, $NR}' file.txt`

On the outset, `NR` might not come across as super useful, but it is excellent once you need to do math like finding the average of a column. 

`awk '{sum = sum + $1} END {print sum / NR}' file.txt`

The syntax here is broken into a few parts. First, `{sum = sum + $1}` adds the value of column 1 to a variable called sum and then assigns that value to the variable sum. Once it gets to the end of the file it will see `END` where it will then carry out `{print sum / NR}`. This divides the current value of sum, which is the sum of the column, by the number of rows. Thus, this will produce an average for a column.

## Bash Scripts

One useful thing you will begin doing to writing your commands in a file, called a script, so that you will have a record of your work. You can write these in nano and `bash` scripts traditionally end with the extension `.sh`. The first line of any `bash` script should be what is called the Shebang line. This tells the computer where to look for the language that your script is written in. The shebang line for computers at IST is 

`#!/bin/bash`

Outside of the Shebang line, no other lines that start with `#` will be run. For this reason, `#` oftentimes will refer to notes or comments. This is a place with the author of the script will say what a line or block of code is doing, so that others who try to read their code can see how it works.

`bash` scripts are capable of using all of the commands you have previously learned. There are some things we will go over that you can do on the command line or in `bash` scripts, but it is often easier, cleaner and repeateable to do them in `bash` scripts.

## for loops

You may be interesting in doing a loop. Loops let you iterate an action multiple times. Let's play like you want to count to 10 with a variable. You could use a `for` loop to achieve this like:

```
for i in 1 2 3 4 5; do
  echo $i 
done
```

In this `for` loop the `for i in 1 2 3 4 5` section sets `i` to each of the values 1, 2, 3, 4, and 5. Once the value of `i` is set to a given number, it will then do the following actions. Sidenote: I am using the variable `i` here. Using `i` is a very common notion for what is called a "counter" variable, or a variable you use to count something. If you have multiple "counter" variables, traditionally, `j` is the next one, followed by `k`, so on and so forth, but you could call them anything you want like `counter_variable_1` and it would still work. Now, that you have `i` set for a value you will `echo $i` which will echo the value of `$i`. Lastly, one the loop is done for a value, it will run into `done`, which tells the loops to go onto the next number in the sequence.

Now, you might think this is nice, but you don't want to type out every number that you want to iterate over. In that case, you can alter the loop to do look like this:

```
for i in {1..5}; do
  echo $i
done
```

Here we have replaced the `1 2 3 4 5` with `{1..5}` and the outcome is the same.

Also, a small note here, you can put this all on the same line with a semi-colon separating each new line (except following `do`), if you want, but it can be tough to read. The previous for loop would look like:

`for i in {1..5}; do echo $i; done`

We can also combine loops and make loops inside of loops like:

```
for i in {1..5}; do
  for j in {1..4}; do
    echo -e "$i\t$j" 
done
```

Here, we have simply put one for loop inside the another loop, so for each value of `i` between 1 and 5, we will loop though every value of `j` between 1 and 4.

## Conditional statements Part 1

Perhaps you would be interested in something occcurring `if` a condition is met. This is how conditional statements operate and an example nested within a loop is below:

```
for i in {1..5}; do
    echo $i
    if [[ "$i" -lt 4 ]]; then
      echo "$i is less than 4"
    fi
done
```

This example is similar to the `for` loops above except `if` the "counter" variable is less than `4`, then I want it to also `echo "$i is less than 4"`. `-lt` stnads for less then. Other conditions are `-gt` for greater than, `-eq` for equal to, `-le` for less than or equal to and `-ge` for greater than or equal to. Note, once a full conditional statement is given you need to write `fi` to mark the end. 

A small sidenote, it is good to get int the habit of putting variables in double quotes when doing conditional statements in `bash`. It doesn't matter for integers, but it does for strings, which we will learn about later.

Another sidenote, `bash` is ***VERY*** finicky about how whitespace is set up in conditional statements. If we use the previous example, t is best to have a use spaces between `[[` and `"$i"`, between `"$i"` and `-lt`, between `-lt` and `4` and lastly between `4` and `]]`.

Last sidenote, sometimes you will see `[` and `]` instead of `[[` and `]]` and the latter is the upgraded version. It can handle things like regular expressions, so I think you always would prefer to use it.

We can also ask the if statement to have multiple conditions that it must meet like

```
for i in {1..5}; do
    echo $i
    if [[ "$i" -ge 2 && "$i" -lt 4 ]]; then
      echo "$i is greater than or equal to 2 and less than 4"
    fi
done
```

Here we use the `&&` to signify "and", so both conditions must be meet. 

You could also achieve this by nesting `if` statements like:

```
for i in {1..5}; do
    echo $i
    if [[ "$i" -ge 2 ]]; then
      if [[ "$i" -lt 4 ]]; then
        echo "$i is greater than or equal to 2 and less than 4"
      fi  
    fi
done
```

This and th previous statemet are equivalent, but the second statement give you a little more flexiiblity if you wanted to `echo` one output everytime it is greater than or equal to `2` and another output when it is greater than or equal to `2` and less than `4`.

You can use `||` to signify "or", so only one of the conditions must be met like:

```
for i in {1..5}; do
    echo $i
    if [[ "$i" -le 2 || "$i" -gt 4 ]]; then
      echo "$i is either less than or equal to 2 or greater than 4"
    fi
done
```

You can also use `else` as part of your `if` statement and it is used whenever the condition in the `if` statement fails like:

```
for i in {1..5}; do
    echo $i
    if [[ "$i" -lt 4 ]]; then
      echo "$i is less than 4"
    else
      echo "$i is greater than or equal to 4"
    fi
done
```

In this example, `if` the "counter" variable is less than 4, then it will `echo "$i is less than 4"`, otherwise it will `echo "$i is greater than or equal to 4"`.

You can also add secondary conditions called `elif`, short for ***el***se ***if***, for when the first `if` condition fails, but before it gets wrapped up in `else`. An example of this would be like:

```
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
```

For the most part, `elif` is functionally the same as having an `if` inside of `else`.  

## until loops

There are several different varieties of loops besides `for` loops. One type of loop called an `until` loop and this loops runs `until` some condition is met. An example of an `until` loop is:

```
i=10
until [[ "$i" -le 5 ]]; do
    echo "$i is not less than of equal to 5"
    i=$(echo "$i - 1" | bc -l )
done
```

In this case the counter variable, `i`, is initially set to 10 and then the loop runs `until` the "counter" variable is less than or equal to `5`. While, that is true we want it to `echo "$i is not less than of equal to 5"` and then tick the "counter" variable down one by doing `i=$(echo "$i - 1" | bc -l )`.

It should be noted that using `i=$(echo "$i - 1" | bc -l )` is this case is fine, but it is a bit overkill. While, it is true that base does poorly with math, it can add and substract integers and there the following are acceptable substitutes for `i=$(echo "$i - 1" | bc -l )`:

`i=$(($i-1))`

(This is my perferred method, but all of these are synonymous)

Or

`let i-=1`

Or

`let i--`

## while loops

I think `while` loops are some of the most useful loops. The first use for `while` loops is not as useful and it is somewhat similar to `until` loops. `while` loops will continue to run `while` a statement is true. Once the statement is false, they will exit. An example is like:

```
i=0
while [[ "$i" -lt 5 ]]; do
  echo "$i is less than 5"
  i=$(($i+1))
done
```

However, this is not the most powerful use for `while` loops. People will often use `while` loops to read files and this will read in a file one line at a time until it hits the end of the file. An example of how to do this using our `animal_noises.txt` from Day 1 looks like:

```
while read animal noise; do
  echo "The $animal goes $noise."
done < animal_noises.txt
```
We know that column 1 of `animal_noises.txt` are the animals and column 2 are the noises. The `while read animal noise; do` tells the computer that `while` you can still `read` the input (which comes from the end and we will talk about) assign what is in the first column to the variable `animal` and what is in the second column to the variable `noises`. If this file has more than two columns and we ran this same script, the first column would still get assigned to `animal`, but `noises` would get the rest of the line. Then, `echo "The $animal goes $noise."` tells the the computer to print out the variable `$animal` and the  variable `noise` from that line in a sentence. Lastly, `done < animal_noises.txt` says to do this `while` there are still lines to read from the file `animal_noises.txt` and this is where your file input is placed. It always feels weird to me that it is at the end, but this is the syntax in `bash`.

## Conditional Statements Part 2

Now, that we know how to read a file in, you might want to know how to use conditional statements on strings instead of just numbers. The syntax is largely similar, and we will modify the last `while` loop to use a string matching conditional statement like:

```
while read animal noise; do
  if [[ "$animal" == "Cow" ]]; then
    echo "The $animal goes $noise."
  fi
done < animal_noises.txt
```

In this example, the variable `$animal` must ***EXACTLY*** match the complete word `Cow` since `Cow` is in double quotes. However, as I said earlier since we are using `[[` and ']]' instead of `[` and `]`, we can use regular expressions. If we want to match something using a regular expression, then you need to change `==` to `=~` and you do not put the pattern you are searching for in double quotes like:

```
while read animal noise; do
  if [[ "$animal" =~ e$ ]]; then
    echo "The $animal goes $noise."
  fi
done < animal_noises.txt
```

## Arrays

Arrays are an interesting data structure that hold a given string or value in given position in the inventory of strings and values. An example of this in `bash` would look like:

`declare -a animal_array=( "Cow" "Pig" "Chicken" "Dog" )`

This is how you would declare an array of animals. Be careful not to put a space until after the `(`. In this array, `Cow` is in the `0` position, `Pig` in in the `1` position, `Chicken` is in the `2` position and `Dog` is in the `4` position. This is considered zero-based index since the initial position in the array starts at `0`.

Now, if you want to `echo` the item in the `2` position, then you need to:

`echo ${animal_array[2]}`

And it should return:

`Chicken`

You can also use a `for` loop to loop through arrays like:

```
for animal in "${animal_array[@]}"; do 
  echo $animal
done
```

The `animal in "${animal_array[@]}"` just says that each element (or piece of the array) will be assigned the variable `animal` as the loop goes through it.

If you want to get rid of an element in a positon of an array you need to use `unset` like:

`unset animal_array[2]` 

This will remove the element in the `2` position in the array.

You can also overwrite elements like:

`animal_array[0]=Cat`

This will replace the `0` position element that was previously `Cow` with `Cat`. 

## argv array

While, arrays are somewhat limited in useful in `bash` there is a nice feature of them using what is called the argv array. The argv array is used to take inputs from the command line and assign them to variables within your script. Typically, when you run a `bash` script it will look like:

`bash some_bash_script.sh`

However, you can give bash script input using the argv array. In this case, you can feed it:

`bash some_bash_script.sh element_1 element_2 element_3`

Then, `some_bash_script.sh` you can assign these elements to variables like:

```
variable_1=$1
variable_2=$2
variable_3=$3
```

In this case, `variable_1` will now be equal to `element_1`, `variable_2` will now be equal to `element_2` and `variable_3` will now be equal to `element_3`. 

It is important to note, that this does ***not*** use zero-based indexing.

## Associative arrays

Associative arrays are immensely useful and are composed of two parts, a key and a value. Every key is unique and it has a value assigned to it. Thus, you can call a key and it will return a value. These are called hashes in `Perl` and dictionaries in `Python`.

`declare -A animal_noises_associative_array`

This will initialize your associative array and `-A` denotes that it is an associative array. Next you want to add things to it like:

`animal_noises_associative_array["Cow"]="Moo"`

In this case, `Cow` is the key and `Moo` is the value within the associative array named `animal_noises_associative_array`. You can add a few more animal noises like:

```
animal_noises_associative_array["Pig"]="Oink"
animal_noises_associative_array["Owl"]="Hoot"
```

Now you can call, an retrieve a value in the array using the key like:

`echo ${animal_noises_associative_array["Pig"]}`

And this should retrieve:

`Oink`

Also, note that you can overwrite entries since keys ***MUST*** be unique. You can do this by doing:

`animal_noises_associative_array["Cow"]="Moooooooo"`

Now, the `Cow` entry is `Moooooooo` instead of `Moo`.

You could also read in a file like `animal_noises.txt` and assign the animal variable as the key and the noise variable as the value, then query them like:

```
declare -A animal_noises_associative_array_2
while read animal noise; do
  animal_noises_associative_array_2["$animal"]="$noise"
done < animal_noises.txt

echo -e "The pig goes ${animal_noises_associative_array_2["Pig"]}."
echo -e "The chicken goes ${animal_noises_associative_array_2["Chicken"]}"
echo -e "The rooster goes ${animal_noises_associative_array_2["Rooster"]}"
```

## Conclusion

At this point, you have a solid underpinning of the types the things you can do in the Unix command line and also have a flavor the the types of tools in many programming languages. There are small thing here and there that I have not mentioned, but I think I have covered the big picture. You are welcome to always use this as a resource and if you find a mistake please notify me so that I can update it. Thank you and I hope you have found this tutorial into Unix and progamming useful.

  
