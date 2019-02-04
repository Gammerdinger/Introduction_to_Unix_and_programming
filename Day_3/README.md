Today we are going to probe into a little more depth with a few commands and also introduce the fundamentals of programming.


# Variables

We have discussed variables enough that I should tell you what they are and how to assign them. Variables are a type of architecture that can hold a string or value.

# Advanced awk

Last class, you saw how powerful `awk` could be of working with columns, particularly with regular expressions. `awk` is also very powerful for doing math, particularly between columns. Let imagine that you have a file, named file.txt, and you want to substract the second column from the first column. Then you could do something like:

`awk '{print $1 - $2}' file.txt`

You can also 
