#!/bin/bash

# If/Else Conditionals in Bash
# Demonstrates if, elif, else, and various test conditions

# 1. Basic if/else
echo "Enter a number:"
read num

if [ $num -gt 0 ]; then
    echo "$num is positive"
elif [ $num -lt 0 ]; then
    echo "$num is negative"
else
    echo "You entered zero"
fi

# 2. String comparison
echo "Enter your favorite language:"
read lang

if [ "$lang" = "bash" ]; then
    echo "You love the shell!"
elif [ "$lang" = "python" ]; then
    echo "A great scripting language!"
else
    echo "$lang is cool too!"
fi

# 3. File tests
FILE="hello.sh"

if [ -e "$FILE" ]; then
    echo "$FILE exists"

    if [ -r "$FILE" ]; then
        echo "$FILE is readable"
    fi

    if [ -w "$FILE" ]; then
        echo "$FILE is writable"
    fi

    if [ -x "$FILE" ]; then
        echo "$FILE is executable"
    fi
else
    echo "$FILE does not exist"
fi

# 4. Directory test
if [ -d "/tmp" ]; then
    echo "/tmp is a directory"
fi

# 5. Combining conditions with && (AND) and || (OR)
echo "Enter your age:"
read age

if [ $age -ge 13 ] && [ $age -le 19 ]; then
    echo "You are a teenager"
elif [ $age -ge 20 ] || [ $age -le 0 ]; then
    echo "You are not a teenager"
fi

# 6. Using [[ ]] for pattern matching
echo "Enter a filename:"
read filename

if [[ "$filename" == *.sh ]]; then
    echo "That's a shell script!"
elif [[ "$filename" == *.txt ]]; then
    echo "That's a text file!"
else
    echo "Unknown file type"
fi

# 7. Checking if a variable is empty
echo "Enter something (or just press enter):"
read input

if [ -z "$input" ]; then
    echo "You entered nothing"
elif [ -n "$input" ]; then
    echo "You entered: $input"
fi
