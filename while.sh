input=hello
while [ "$input" != "bye" ]
do
 echo "Enter text (bye to quit):"
 read input
 echo "You typed: $input"
done
