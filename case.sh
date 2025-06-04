echo "Good Morning people!"

while :
do
 read input
 case $input in
  hello)
       echo "Hello!"
       ;;
  bye)
      echo "Bye!"
       ;;
  *)
   echo "Sorry, I don't understand"
   ;;
esac
done
echo
echo "That's all folks!"
