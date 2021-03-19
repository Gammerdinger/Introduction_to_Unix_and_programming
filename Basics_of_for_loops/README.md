# Basics of *for* Loops

## The Problem

You have a long list of items that you would like a series of commands to be iterated over. Common examples of this could be:

* You want to repeat an action a set number of times
* You want to modify many similar files

## The Solution

Loops!!! All of these problems are perfect places to implement loops. Loops ar a common programming structure found in virtually all programming languages. Generally speaking, there are several varieties of loops including *for* loops, *while* loops, *until* loops among others. The most common loops are *for* loops, but the other loops certainly have their places. For example, *while* loops are frequently used for reading files. In this tutorial, we are going to focus on *for* loops.

## Expected Learning Outcomes

* To modify an existing *for* loop
* To design a *for* loop

## Basic Syntax

*for* loops generally have several key components:

* A counter variable
* An end condition
* An increment

### Counter Variable

This will be the variable that you will be changing with your *for* loop. 

### End Condition

This is the condition that will continue to run your loop as long as it returns true. 

### Increment

This is the step size with which you would like to increase the counter variable. It should be noted that when using *for* loops on a list of items, a default increment of 1 is assumed.

## Examples

A C-style *for* loop in *bash* would look like this:

```
  for (( i = 0; i <= 10; i = i + 1 )); do
    echo $i
  done
```

Let's break down each of these components.

-`i = 0` This is your counter variable. We are initializing it and setting it equal to 0. Of course, you could set this to anything you want. 

-`i <= 10` This is your end condition. If counter variable `i` is less than or equal to 10, then the loop will run.

-`i = i + 1` This is your increment. After each iteration of your loop, your counter variable will be increased by 1. Of course, you could set the value added to anything and you could do something like `i = i + 2` if you wanted the increment step to be two each time.

### A few shortcuts

Few people actually write their *bash for* loops as explicitly as I have done above. There are a few shorthands that you will often see. 

#### *i++*

Instead of `i = i + 1`, people will often shorten this to `i++`. `i++` and `i = i + 1` are equivilant terms. The only downside to this shorthand is that you *have* to to use increments of one, which for most people's purposes is what they want anyway. Something like this would look like:

```
  for (( i = 0; i <= 10; i++ )); do
    echo $i
  done
```

#### *$(seq START END)*

-`$(seq START END)` This uses the `seq` command in *bash* to create a sequence with an increment size of one. The following *for* loop gives the same output as the previous *for* loop.

```
  for i in $(seq 0 10); do
    echo $i
  done
```

#### *{START..END}*

-`{START..END}` This can further be shortened to look like this. This form is the most common form of *for* I find people use. An Example that is equivilant to the above examples is simply:

```
  for i in {0..10}; do
    echo $i
  done
```

You can see that this is ***MUCH*** easier to work with than the previous C-style *for* loop. 

#### *$(seq START INCREMENT END)*

This is similar  to `$(seq START END)` but this allows you to pick your increment step. If you wanted to go from 0 to 10 by twos you would use:

```
  for i in $(seq 0 2 10); do
    echo $i
  done
```

#### *{START..INCREMENT..END}* (if using Bash v4.0+) 

Similarly, if you are running Bash v4.0+, then this is similar to `{START..END}`, but with the increment component added to it. 

```
  for i in {0..2..10}; do
    echo $i
  done
```

### Lists

Another common way people use *for* loops in *bash* is to interate through a list. An example of this would look like this list of colors:

```
for i in red orange yellow green blue indigo violet; do
  echo $i
done
```

If you had multi-word elements in this list (I would try to use underscores instead of spaces), but you can use `''` to capture it like we have done for dark orange, emerald green and pale blue below:

```
for i in red 'dark orange' yellow 'emerald green' 'pale blue' indigo violet; do
  echo $i
done
```
