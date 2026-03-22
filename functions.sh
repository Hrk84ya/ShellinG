#!/bin/bash

# Functions in Bash
# Demonstrates defining and calling functions, return values, and local variables

# 1. Basic function
greet() {
    echo "Hello, welcome to shell functions!"
}

greet

# 2. Function with parameters
greet_user() {
    echo "Hello, $1! You are $2 years old."
}

greet_user "Alice" 30
greet_user "Bob" 25

# 3. Function with a return value (exit code)
is_even() {
    if [ $(( $1 % 2 )) -eq 0 ]; then
        return 0
    else
        return 1
    fi
}

is_even 4 && echo "4 is even" || echo "4 is odd"
is_even 7 && echo "7 is even" || echo "7 is odd"

# 4. Function that outputs a result (capture with $())
add() {
    echo $(( $1 + $2 ))
}

result=$(add 10 20)
echo "10 + 20 = $result"

# 5. Local variables vs global variables
my_var="I am global"

change_var() {
    local my_var="I am local"
    echo "Inside function: $my_var"
}

echo "Before function: $my_var"
change_var
echo "After function: $my_var"

# 6. Recursive function (factorial)
factorial() {
    if [ $1 -le 1 ]; then
        echo 1
    else
        local prev=$(factorial $(( $1 - 1 )))
        echo $(( $1 * prev ))
    fi
}

echo "Factorial of 5 is $(factorial 5)"
