startMsg = "Welcome to the Robe Store 
/
/
 what you want use /
 1) flatpak /
 2) apt /
 3) docker containers(coming soon) /
 4) exit 
"

echo $startMsg

while true; do

read act
case "$act" in 
1)
echo "flatpak"
;;
2)
echo "apt"
;; 
3)
echo "not avalable"
;;
4)
echo "bye"
break
;;

done
