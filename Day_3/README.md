Today we are going to probe into a little more depth with a few commands and also introduce the fundamentals of programming. In this exercise, we are going to focus on programming using `bash`, which is a common shell for the Unix environment. I do hesitate to teach you all very much `bash` because it is ***VERY*** finicky when it some to proper syntax and programming languages like Perl and Python are ***MUCH*** more forgiving. However, you may want/need to use it is some cases and most programming languages are largely similiar in capabilities for beginners. That being said, moving forward after this course, I would encourage you to learn Perl or Python for most of your programming needs (probably Python is the better choice, but a dying breed of programmers including myself use Perl). However, in order to introduce Perl (or likely Python for that matter), I would need to introduce you to some idiosyncrasies of these languages.


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

The syntax here is broken into a few parts. First, `{sum = sum + $1}` adds the value of column 1 to 