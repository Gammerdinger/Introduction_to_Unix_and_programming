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

A C-like style for a *for* loop in *bash* would look like this:

```
  for (( i = 0; i <= 10; i = i + 1 )); do
    echo $i
  done
```

Let's break down each of these components.

-`i = 0` This is your counter variable. We are initializing it and setting it equal to 0. Of course, you could set this to anything you want. 

-`i <= 10` This is your end condition. If counter variable `i` is less than or equal to 10, then the loop will run.

-`i = i + 1` This is your increment. After each iteration of your loop, your counter variable will be increased by 1. Of course, you could set the value added to anything and you could do something like `i = i + 2` if you wanted the increment step to be two each time.
