# Solutions

## Comprehension Check

*Question 1*

Which of these is NOT a necessary part of a *for* loop?

A) Counter Variable

B) End Condition

**C) Associative Array**

D) Increment

*Quesiton 2*

Which of these for loops will run the counter variable from 1 to 5 with an increment of 2?

A)

```
for (( i = 1; i <= 5; i = i + 2 )); do
  echo $i
done
```

B) 
```
for i in {1..5..2}; do 
  echo $i; 
done
```

C)
```
for i in $(seq 1 2 5);do 
  echo $i; 
done
```

**D) All of the above**


## Question 1

Use a *for* loop to echo the numbers between 4 and 14.

```
for i in {4..14}; do 
  echo $i; 
done
```


## Question 2

Within a directory you have five .fasta files (named sequence_1.fasta, sequence_2.fasta, sequence_3.fasta, sequence_4.fasta, sequence_5.fasta) that are taking up some space. You would like to compress only the odd numbered sequences using *gzip*. Design a *for* loop to accomplish this task.

```
for i in {1..5..2}; do 
  gzip sequence_$i.fasta; 
done
```
