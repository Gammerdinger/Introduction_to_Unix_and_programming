# Day 1: Navigating the Unix Hierarchy

## Hierarchical Design of Unix systems

You can think of Unix systems similarly to folders on your computer. Within a folder you may have photos, documents and even other folders. However, "folders" are called directories on Unix systems and everything is contained in a hierarchical system of these directories. The highest directory in the system has a special name and it is called "The root". The directory above another directory in the hierarchy is called its "Parent directory".

## Absolute paths

A path is a way of describing where something (directory or file) is in the hierarchy of directories. Absolute paths ALWAYS start at the root. The root is designated with an initial forward slash `/`. Each subsequent directory is denoted with its name and followed by a forward slash. An example of an absolute path to a file might look like: 

`/Users/Will/Photos/Summer/beach_picture.jpg`

In this example there was a directory at the root called `Users`, which had another directory inside of it named `Will`, which had another directory called `Photos` within it, which had a subsequent directory within that called `Summer`, which has the photo `beach_picture.jpg` that I am interested in.

## pwd

Where am I? `pwd` stands for **p**resent **w**orking **d**irectory and it will give you the absolute path (from the the root) to the current directory that you are located in. It can be called using this command:

`pwd`

## ls

What is in this directory? Okay, so you now know where you are located in the hierarchy using `pwd`, but you want to know *WHAT* is in this directory. `ls` stands for **l**i**s**t and it lists all non-hidden files in a directory. Hidden files are beyond the scope of this course, but they can be visualized with the `-a` option. We will discuss options soon. If `ls` is by itself the default is to list the directories and files in your current directory.

`ls`

However, `ls` can also be used to see the contents of other directories that you have permission to look at. For the previous example I could have entered 

`ls /Users/Will/` 

Perhaps it may have returned directories called `Music`, `Photos`, `Documents`, `Downloads` and `Applications` along with some files that I don't have in any directory called `Dissertation_talk.ppt` and `wallpaper.png`. Try looking in a directory that is two levels below the root. You can just copy the first two levels from the `pwd` command. For me, this looks like:

`ls /home/thin`

This returns:

`Desktop	Documents	Downloads	Music	Pictures	Public scripts	Templates	Videos`

In this example there are only directories, but it is possible for files to exist here as well.

You can even `ls` several directories at once by separating each directory with a space. In my previous example I could have done:

`ls /Users/Will/ /Users/Anja/ /Users/Will/Music`

In this example it would display the contents of each directory separately. If you also want to display the contents of the current directory as well, all you need to do is use `.` separated by spaces to your command. For example:

`ls /Users/Will/ /Users/Anja/ /Users/Will/Music/ .` 

This would show me the three previous directories that I saw in the previous command plus the current directory that I am in. 

## Relative paths

Relative paths are paths that start from your current location rather than the root. In the previous example with the absolute path `/Users/Will/Photos/Summer/beach_picture.jpg` and you were already located inside `/Users/Will/Photos`, then the path to `beach_picture.jpg` would be:

`Summer/beach_picture.jpg`

You can use `..` to move up in the heirarchy. If I was in `/Users/Will/Music` and I wanted the path to `/Users/Will/Photos/Summer/beach_picture.jpg`, then I could describe it as: 

`../Photos/Summer/beach_picture.jpg`

If I was in the directory `/Users/Will/Music/iTunes_library`, then I could give the path to the same jpg file using multiple `..` like: 

`../../Photos/Summer/beach_picture.jpg`

However, note that relative paths do not work if you think you are in a different directory than you actually are. For instance, if you were in `/Users/Will/Music/iTunes_library/`, but you thought you were in `/Users/Will/Music/` then 

`../Photos/Summer/beach_picture.jpg`

would not properly describe the location of this file

Relative paths can also go from your home (not the root) directory using `~/`. The home directory you can think of as sort of like the root directory for a given user. In the previous example, the home directory is likely `/Users/Will/`. You can find out your home directory by typing in this:

`echo $HOME`

This uses the `echo` command that we will talk about next class and a special variable called the $HOME variable, which stores the path to your home directory.

Relative paths are often quite useful and are much quicker to use than absolute paths since they are shorter. Personally, I use relative paths when navigating around the UNIX hierarchy. However, If I am providing paths of files to run a software package, I will often use the absolute path as I want to specify its location and not run into the aforementioned error after waiting for time on the computer cluster for 3 days. Yes, it has happened to me. No, it is not fun. Yes, it took several times to learn this lesson. Careful programming can often alleviate this concern, but I use it as a best practice as it assure me that silly errors will be minimized. 


## Spaces

Now is a good time to pause and talk about spaces. Spaces, unless properly handled with a preceding back slash `\` (which is called an escape), often signify separations. You will often see people, including myself, substitute spaces with underscores `_` in directory names and file names. This is certainly a best practice because some things handle spaces in strange and unexpected ways and the easiest way to avoid this is just to use underscores. Less commonly, people sometimes use periods or dashes instead spaces, but my perception is that most people use underscores. Let's go back to my first example and replace underscores with spaces and try to understand how the the computer would understand the command

`ls /Users/Will/Photos/Summer/beach picture.jpg`

In this case the computer would to run `ls` on two files. First, it would try to run `ls /Users/Will/Photos/Summer/beach`, then on something in my current directory called `picture.jpg`. Thus you can see that spaces are problematic. You could get around this doing something like:

`ls /Users/Will/Photos/Summer/beach\ picture.jpg`

But this is generally not advisable for the aforementioned reasons

## Options

Well, I want to do something like `ls` (or many other commands), but I want it in a slightly different flavor. No fear, options are here to help you and they are plentiful!!! There can be dozens of options for a given command and so there is no need to try to memorize them all, but throughout this course I will try to show you ones that I like and how to find out more. Options can be added to a command by giving them a space followed by a dash and a corresponding letter. For example, the earlier `ls /home/thin/`, it can be modified with the `-l` option:

`ls -l /home/thin`

This now returns:

```
total 36K
drwxr-xr-x 2 thin thin 4.0K Dec  7  2017 Desktop
drwxr-xr-x 2 thin thin 4.0K Jul 28  2017 Documents
drwxr-xr-x 2 thin thin 4.0K Jul 28  2017 Downloads
drwxr-xr-x 2 thin thin 4.0K Jul 28  2017 Music
drwxr-xr-x 3 thin thin 4.0K Jul 28  2017 Pictures
drwxr-xr-x 2 thin thin 4.0K Jul 28  2017 Public
drwxr-xr-x 2 root root 4.0K Dec  7  2017 scripts
drwxr-xr-x 2 thin thin 4.0K Jul 28  2017 Templates
drwxr-xr-x 2 thin thin 4.0K Jul 28  2017 Videos
```

The `-l` option for `ls` returns what is called the long list format. The first column tell you the permissions for the file or directory (who can do what to the directory or file). The third column is the owner of the directory or file. The fourth column is which group the owner belongs to. The fifth column tell you the size in bytes of the file or directory. However, directory sizes are strange and this number doesn't correspond the the amounts of space that the contents of the directory take up. I believe the default on the lab computers is to use the `-h` option that we will talk about next though. The sixth column tell you the last time this directory or folder was modified and the seventh and final column tell you the name of the file of directory.

You can put multiple options together in the same command. Personally, I like to add the `-l` and the `-h` options to my `ls` commands. `-h` changes the file sizes output in the fifth column to be human-readable (in other words, use the kilobyte, megabyte, gigabyte notation). For example, my earlier `ls` command `ls -l /home/thin/` modified with the `-h` option

`ls -l -h /home/thin`

Or even better you can collapse the options, so that it looks like this

`ls -lh /home/thin`

However, as I said earlier the default on the lab computers is to have `-h` option

## man

At this point you are probably thinking, "Gee, it sure is great that Will can just tell me the options I need to know, but what if Will isn't around or I want to see other options?" That is where the `man` command comes in. You can put `man` in front of any command and it will bring you up the **man**ual on how to use that command. For example you can read the manual for the ls command using:

`man ls`

To navigate the manual you can use the up or down arrows on your keyboard. You can also use the space bar and it will skip down a full page. You will see here that there are MANY options for `ls` (including the `-a` option I mentioned earlier for showing hidden files). Many of these have specific uses and I rarely use them. To exit the manual just hit `q` to Quit

## Tab-completion

Before we get any further, I want to save you and myself a lot of headaches by teaching you tab-completion. I know it feels a bit foreign at first but over time it will feel natural.

What is tab-completion and why does Will insist that I use it? Tab-completion is a nifty trick to save time when typing by pressing `tab`. Once you are typing something that becomes unique to that folder, press `tab` and it will auto-complete the writing. Let's imagine this was my `Photos` directory:

```
picture_1.jpg
picture_2.jpg
beach_picture.jpg
besties.jpg
```

When I type `ls -lh bea` and press `tab`, it will complete it so that it is `ls -lh beach_picture.jpg`. However, if I were to type `ls -lh be` and press `tab` it would do nothing because there are two entries that both start with "be". In this case, you can hit `tab` twice quickly in succession and it will show you all of the entries that start with "be".

Also, I can type `ls -lh p` then press `tab`, and it will complete it until it is non-unique. In this case it would auto-fill it to `ls -lh picture_`

So why do I, and as an extension you, care about tab-completion? First, and absolutely foremost, it cuts down on errors. A lot. Since typos wouldn't tab-complete it is a great way to catch typos, which is one of the most common problems when something isn't working. Second, it is going to save you a ton of keystrokes and time. I really can't emphasis this enough: Ingrain tab-completing as a habit.

## cd 

You now know where you are with `pwd` and what is in any directory that you could want to access, however you likely want to know how to move between directories. This is the function of the `cd` command, which stands for **c**hange **d**irectory. To change directories, you use the `cd` command followed by the path (relative or absolute) to the directory you'd like to change to. In the above example, if you were in `/Users/Will/Music/iTunes_library/` and you wanted to go to `/Users/Will/Photos` you could go this by either of two ways:

### 1) Using a relative path:

`cd ../../Photos`

### 2) Using an absolute path

`cd /Users/Will/Photos`

Note, you can also use a path from your home directory. If your home directory was `/Users/Will/` and you wanted to go to `/Users/Will/Photos`, then you could use:

`cd ~/Photos`

All of these ways are equivalent and which you use will likely depended on your preference

## nano

You have a wide variety of text editors to pick from. The most popular choices are probably Vim and emacs for reasons that are outside of the scope of this course. However, I only know emacs and it can be a bit tricky for beginners so we are going to use a simple text editor called nano.  You can make a file by typing `nano` followed by the name of the file that you would like to make, like:

`nano Hello_world.txt`

Once inside nano you can type `Hello world!!!`. You can exit nano by holding `Control` and pressing `x`. Then press `y` to save the changes. Then press `Enter` if you would like to save the file or you can change the name to something else and it will make a new file with that name.

## cat 

If you would like to display a full file you can use the `cat` command followed by the file name.  For example, if you would like to display the file, `Hello_world.txt` that you just made you can use the command:

`cat Hello_world.txt`

And it should return:

`Hello world`

You can also use `cat` to print out multiple files. Do to this, you will call `cat` followed by each file separated by a space (see spaces are important!!!)

`cat animal_noises.txt Hello_world.txt`

This will print out the list of animal all of the animal noises followed by your `Hello_world.txt` file.

```
Cow    Moo
Pig    Oink
Duck   Quack
Cat    Meow
Dog    Woof
Horse  Neigh
Mouse  Squeak
Frog   Ribbit
Bee    Buzz
Rooster	Cock-a-doodle-do
Chicken	Cluck
Sheep	Baa
Donkey	Hee-haw
Owl	Hoot
Bird	Chirp
Turkey	Gobble
Goose	Honk
Cricket	Chirp
Lion	Roar
Hello world
```

## head 

Some files may be quite large and you are just interesting in seeing the first few lines. You oftentimes use this if the top line of the file is a header and tells you what each column stands for or maybe you know you are looking for something that is at the top of the file. Either way, you might be interesting in only printing the top few lines rather than the whole file. This is where the `head` command is useful. You can call `head` then the file name (or multiple file names separated by a space just like `cat`) and it will show you the first 10 lines of the file (or first 10 lines of each file).

`head animal_noises.txt`

This returns the first 10 lines of `animal_noises.txt` that I made.

However, sometimes you are not interested in the first 10 lines and you want the first line, first 5 lines or the first 14 lines. This is where the `-n` option comes in. The `-n` option allows you to specify the number of lines you'd like in your `head` command and `-n 10` is the default. When printing the first line, first 5 lines of first 14 lines, you would use `head -n N` then your file, where N is the number of desired lines.

`head -n 1 animal_noises.txt`

`head -n 5 animal_noises.txt`

`head -n 14 animal_noises.txt`

Note, if a file is shorter than the number of desired lines in the head, then it will simply stop at the end of the file.

## tail

You may be interested to see only the end of the file instead of the whole file. This is where you will use the `tail` command. This command is particularly useful when a software package is writing to a file and you would like to check on the progress of it by looking to see what the last item written to an output file was. You can call it using `tail` followed by the filename, like:

`tail animal_noises.txt`

It will, by default, return the last 10 lines of the file. Similarly to the `head` command, you can alter this with the `-n` option. So, if you want the last line of a file or the last 11 lines of a file you could use the following commands, respectively:

`tail -n 1 animal_noises.txt`

`tail -n 11 animal_noises.txt`

## less

You may also be interested in viewing a file, but you don't want to print out the file. This is when you would use the `less` command.

Sidenote: There is also a `more` command and the functionality is largely similar to `less`, but I think the general consensus is that `less` is a bit better. Because of this the `more` command will be outside the scope of this course.

To use the `less` command type `less` followed by the file name, like:

`less O_niloticus_missense.txt`

You can use the arrows on your keyboard to scroll up and down this file (like in the `man` command). You can also use space to go down a whole page (like in the `man` command). You can exit `less` by pressing `q`.

Also, `less` has a search feature. If you would like to search forward in the file it that require you to press `/` followed by typing your search term followed by `Enter`. If you would like to search backward in the the file it requires that you press `?` followed by typing your search term followed by `Enter`. This will highlight the results of your search. You can press `n` to go to the next hit (forward or backward depending on your previously stated search direction) in your search.

For example, once you have called `less mutations.txt`, you can press `/` then enter `LG2` and press `Enter`. This will find the first instance of "LG2" going forward in the file from your current location. You can press `n` to go to the next occurrence.

Other useful aspects of `less` include the use of `<` and `>`. While having a file open in `less`, you can press `>` to go to the end of the file or `<` to go to the beginning of the file.

## cp

You may be interested in copying a file. The `cp` command will **c**o**p**y a file. The syntax for using the copy command is `cp` followed by the the path (absolute or relative) of the file and then followed by the path to the new copy. If you wanted to make a copy of the `animal_noises.txt` file and call it `animal_noises_2.txt` and you were in the directory that contained `animal_noises.txt`, then you could use:

`cp animal_noises.txt animal_noises_2.txt`

If the path to `animal_noises.txt` was `/Users/Will/Documents/animal_noises.txt` then you could also use absolute paths like:

`cp /Users/Will/Documents/animal_noises.txt /Users/Will/Documents/animal_noises_2.txt`

Now, you might also be interested in copying this file to a different directory, `/Users/Will/Music/`, then you could use:

`cp /Users/Will/Documents/animal_noises.txt /Users/Will/Music/animal_noises.txt`

Or if you were in `/Users/Will/Documents/` and you wanted to use relative paths then you could use:

`cp animal_noises.txt ../Music/animal_noises.txt`

Or you could use a mix of absolute and relative paths if you are in `/Users/Will/Documents/`, either:

`cp /Users/Will/Documents/animal_noises.txt ../Music/animal_noises.txt`

Or

`cp animal_noises.txt /Users/Will/Music/animal_noises.txt`

You could also use the `~` and do something like:

`cp animal_noises.txt ~/Music/animal_noises.txt`

It can also be noted that you do not need to be in any specific directory to copy files between directories. You could be in `/Users/Will/Photos/` and move `animal_noises.txt` from `/Users/Will/Documents/` to `/Users/Will/Music/` using:

`cp /Users/Will/Documents/animal_noises.txt /Users/Will/Music/animal_noises.txt`

Or

`cp ../Documents/animal_noises.txt ../Music/animal_noises.txt`

Also, for files where you want to keep the name the same, it is not necesscary to write out the name of the file in the path where the file will be placed. For example, the previous command could also be:

`cp ../Documents/animal_noises.txt ../Music/`

There are tons of combinations that `cp` can be used in that are equivalent and you can choose when and how you'd like to uses each one.

Instead of copying files, you may be interested in copying directories. In order to copy directories, you need to use the `-R` or `-r` option (they are the same for this command), which stands for recursive. If you want to copy the directory `iTunes_library/` from `/Users/Will/Music/` to `/Users/Anja/Music/`, then you would use the following:

`cp -r /Users/Will/Music/iTunes_library/ /Users/Anja/Music/iTunes_library/`

However, note this would only work if `/Users/Anja/Music/iTunes_library/` did not already exist. If `/Users/Anja/Music/iTunes_library/` did exist then the copied `iTunes_library/` would be copied into `/Users/Anja/Music/iTunes_library/iTunes_library/` and you'd rather want to use:

`cp -r /Users/Will/Music/iTunes_library/ /Users/Anja/Music/`

Lastly, if you copy something to a file the already contains something by that same name, then it will overwrite it without asking. If you do not like this behavior then you can use the `-i` option, which will ask you if you wish to overwrite a file.

########### . ##########

Now is a good time to talk about the `.` symbol. The `.` symbol stands for your current directory. So, you could also copy items from elsewhere to your current directory using the `.` symbol. Let's pretend that you were in `/Users/Will/Music/` and you wanted to move `animal_noises.txt`, which is located at `/Users/Will/Documents/animal_noises.txt`, to this directory. Then you could use:

`cp /Users/Will/Documents/animal_noises.txt .`

Or

`cp ../Documents/animal_noises.txt .`

## mv

Now that you know how to copy something, you may want to know how to instead just **m**o**v**e it or rename it and this is the function of the `mv` command. Many of the conventions following paths that I outlined in the `cp` command can be applied to the `mv` command, so I will not go as in depth with respect to that. If you want to rename a file from a directory that you are in, you would call `mv` followed by the current name of the file followed by the new name of the file, like:

`mv animal_noises.txt noises_from_animals.txt`

You can also move a file or directory using this command by calling the `mv` command followed by the current location of the file or directory and then the new location, like:

`mv animal_noises.txt ../Music/animal_noises.txt`

Note, that you you dont need to use a `-R` or `-r` option when using `mv` to move directories

## mkdir

If you would like to **m**a**k**e a new **dir**ectory, you can use the `mkdir` command. If you are in the directory `/Users/Will/Documents/` and you wanted to make a new directory called `Projects` within this directory, then you would call the `mkdir` command followed by `Projects`, like:

`mkdir Projects`

Of course, you could also do this will an absolute path:

`mkdir /Users/Will/Documents/Projects`

If you wanted to make several directories at the same time you just need to separate them by spaces following the `mkdir` command, like:

`mkdir Directory_1 Directory_2`

## rm

Now you are likely making a mess in your workspace, so you are going to want a way to remove files and directories (we will talk about this in the next section). The `rm` command **r**e**m**oves files and directories. Let me briefly pause and emphasize that `rm` PERMANENTLY removes things. There is **NO** way to recover accidentally deleted items. Please use the command with some caution. To remove a file, call the `rm` command followed by the name of the file you would like to remove. If you would like to remove the duplicate, `animal_noises_2.txt`, that we made earlier, you can use:

`rm /Users/Will/Documents/animal_noises_2.txt`

You can use absolute or relative paths with this command, I am just showing an absolute path here. If you would like the computer to confirm with you that you mean to remove a file you can use the `-i` option, like:

`rm -i /Users/Will/Documents/animal_noises_2.txt`

Depending on the computer or computer cluster you are working on the `-i` option **MAY** be the default. If you are on a system where the default is `-i` and this annoys you, you can use the `-f` option to force remove a file Just a note, the `-f` option can really be devastating if you are not careful with it, particularly if you combined with the `-r` option. We will talk about this in the next section. I have twice lost a month's worth of work using `-rf` because ofthis mistake, so ***BE CAREFUL*** using the `-f` option in general, but particularly with the `-r` option. Once again, there is no undoing mistakes with `rm` unless you are on a system that backs things up.

Lastly, you can remove multiple files, but separating them by a space, like:

`rm file_1 file_2`

## rmdir

Now that you know how to make directories, you may want to know how to use the `rmdir` command to **r**e**m**ove **dir***ectories. There are two ways to accomplish this:

### 1) Using the `rmdir` command to remove directories

The `rmdir` command can ony remove empty directories. Thus, if you want to remove a directory with `rmdir` then you must first use `rm` to delete the contents of the directory. Once a directory is empty, you can remove the directory (called `empty_directory_that_I_want_to_delete` in this case) by calling the `rmdir` command followed by the directory name:

`rmdir empty_directory_that_I_want_to_delete`

You can also remove multiple empty directories by separating them with a space, like:

`rmdir directory_1 directory_2`

I would ***STRONGLY*** recommend using this method for while you continue to learn your way around the command line. I am going to show you a different way to remove directories, because I believe you should know of its existence and also give you abundant caution for using it.

### 2) Using `rm -r` (and likely also the derivative the you'll use `rm -rf`) to recursively remove a directory and the files contained within it.

Once again, please proceed with ***EXTREME*** caution. This method can cause enormous irreversible damage quickly. Really, ***BE CAREFUL***. A poorly placed space can delete **EVERYTHING** off of your computer. I'm not kidding, see below for an example. That being said doing mass irreversible damage with this command is almost a rite of passage for people who use the Unix command line often, so try not to beat yourself up when (not if) it happens. If you do misuse it, stop what you are doing, immediately assess the damage done and develop a plan to recover/redo what has been lost. If you somehow start this accidentally you can hold `Control` and press `C` to cancel it, but what has been deleted will remain deleted and it will only stop additional stuff from being deleted. Just a sidenote, holding `Control` and pressing `C` will also stop all other command-line commands.

Okay, so now I feel like I have given you the appropriate caution with regards to this command. If you have a directory that has many files and directories in it, you may want to consider using `rm -r` (or more likely `rm -rf`). This command will delete a directory and all of the files within that directory. The command is `rm -r` followed by the directory (or directories separated by a space), like:

`rm -r directory_to_delete`

I think many systems will treat this command with the `-i` option, which will ask you which directories you want to descend into and confirm that you want to remove each file individually. However, I cannot promise that all systems will have the `-i` option as the default.

If you are using `rm -r`, it is likely because you have a large number of files to delete and thus confirming the deletion of each individual file would be quite tedious. As a result,  most people pair `rm -r` with the `-f` option and use `rm -rf` followed by the directory name, like:

`rm -rf directory_to_delete`

Just to highlight how this could go catastrophically wrong with just one keystroke, imagine you wanted to delete the directory `/Users/Will/Music/iTunes_library/Justin_Bieber/` from your computer using:

`rm -rf /Users/Will/Music/iTunes_library/Justin_Bieber/`

This would work without a problem. However, this next command would be catastrophic:

`rm -rf /Users/Will/Music/iTunes_library/Justin_Bieber /`

That extra space would mean you now have two directories you want to recursively remove without being prompted for a check. The first would be just the `Justin_Bieber` directory like you wanted. The second would be the root, or in other words ***EVERYTHING*** on your computer. I hope this example has taught you two things, use underscores instead of spaces and really pause to think before you run `rm -rf`.
