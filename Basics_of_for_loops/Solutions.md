# Solutions

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
