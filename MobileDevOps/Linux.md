# Linux

### Linux
- Linux is an open source operating system based on UNIX. The operating system is the system software that manages computer hardware and software.
- Linux comes in various flavors /distributions such as— Fedora, Ubuntu, OpenSUSE which are commercial, while Debian and Arch Linux is entirely community driven. All these have the Linux kernel in them.

### Kernel
- The kernel is the heart of the operating system. Linux Kernel is a low-level system software. It provides an interface for user-level interaction. It manages the system resources such as RAM, Disk, Processor, output devices etc.

### Shell in Linux
- Linux shell is basically a user interface. You can enter your inputs into the shell, The shell would execute the commands and communicate with the Linux OS in doing so. There are varieties here too — BASH (Bourne Again SHell), CSH ( C Shell), KSH ( Korn Shell) and TCSH.

### File permissions in Linux
There are 3 types of permissions in Linux OS that are given below:
- Read: User can read the file and list the directory.
- Write: User can write new files in the directory or modify the file.
- Execute: User can access and run the file in a directory.
> *The **chmod** and **chown** commands are used to control access to files in UNIX and Linux systems. The chmod command stands for “change mode”, and allows changing permissions of files and folders in Linux. The chown command stands for “change owner” .*

### sudo
- It stands for “super user do!” .If you add “sudo” before any Linux command, it will run that command with elevated privileges. So you could now perform certain admin tasks such as the installation of servers or reboot.

### Cron
- The software utility cron is a time-based job scheduler. Cron schedules jobs (commands or shell scripts) to run periodically at fixed times, dates, or intervals. You could set it to download a movie every Friday evening (Write a script to download the latest movie and assign it to cron).

### Grep, Awk and Sed
- Grep, awk, and Sed are three of the most useful command-line tools.
- Grep (Global Regular Expression Print) is used to search for specific terms in a file. Eg. to find all the lines in your project report having the word ‘result’.
- Awk is a text pattern scanning and processing language. It is mostly used for data extraction and reporting in Excel files. Eg, To print certain columns of an excel sheet only.
- Sed refers to Stream Editor. It can perform text transformations on a given file or an input stream. Eg, You shared an assignment from your friend. To replace all instances of his name with yours, use Sed.

### Filesystem
- Nearly all Linux distributions are compliant with a universal standard for filesystem directory structure known as the Filesystem Hierarchy Standard (FHS). The FHS defines a set of directories, each of which serve their own special function.
- The forward slash (/) is used to indicate the root directory in the filesystem hierarchy defined by the FHS.
- When a user logs in to the shell, they are brought to their own user directory, stored within /home/. This is referred to as the user’s home directory. The FHS defines /home/ as containing the home directories for regular users.
- The root user has its own home directory specified by the FHS: /root/. Note that / is referred to as the “root directory”, and that it is different from root/, which is stored within /.
- Because the FHS is the default filesystem layout on Linux machines, and each directory within it is included to serve a specific purpose, it simplifies the process of organizing files by their function.
- if we want to indicate parent directory we can use `./currentDirectory`
- if we want to use grand parent directory we can use `../currentDirectory`

### Commands
- **pwd** - prints the path to your current directory.
- **ls** - this will return a list of the names of any files or directories held in your current working directory.
- **cd given_path** - navigate to a specific directory
- **cd ..** - change to the directory one level up in your path
- **mkdir name_of_new_directory** - use to create new directories
- **touch file_name_with_extension** - use to create new files
- **mv file.txt newfile.txt** - use to move or rename
- **cp newfile.txt file.txt** - use to copy contents of one file to another
- **nano file.txt** - use to edit file
- **[cat](https://phoenixnap.com/kb/linux-cat-command)** 
- **less file.txt** -  print the contents of file, but one terminal page at a time beginning at the start of the file. You can use the spacebar to advance a page, or the arrow keys to go up and down one line at a time. Press q to quit out of less.
- **rm file_name** - delete the file
- **rm -d directoryName** - delete empty directory
- **rmdir directoryName** - delete empty directory
- **rm -r directoryName** - delete non empty directory
- **[piping](https://www.codementor.io/linux/tutorial/10-things-every-linux-beginner-should-know)**
- **man** - find manual page of a command

### mv
#### cmd: mv this there
- which moves the file (or directory) from the path this to the path there.
	- If this is a regular file (i.e. not a directory), and:
	- there is a directory,this gets moved inside of there.
	- there is a regular file that exists, then there will get overwritten, becoming a regular file that holds the contents of this.
	- there does not exist, it will be created as regular file whose contents are identical to those of this.
- If this is a directory and:
	- there does not exist in the filesystem, the directory there will be made and its contents will be the (former) contents of this
	- if there already exists, and is a directory, then the directory this will be moved inside of the directory there (i.e. it will become there/this).
	- if there already exists, but is not a directory, then nothing will change in the filesystem, but an an error will be reported. In all cases, whatever used to exist at path this will no longer be found there.
- And mv can be invoked with multiple arguments, in which case the last one must be a directory that already exists that receives all the earlier arguments inside it. So, if you already have a directory named dest_dir then you can move a lot of things into it like: *mv file1 file2 dir1 dir2 dest_dir*























