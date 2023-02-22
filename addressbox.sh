#!/bin/bash



add() {
   if ! [ -e file.txt ];then touch file.txt ;fi
   num=`grep -ic $1 file.txt`
   if [ $num -eq "0" ]
   then
      echo "$1 $2 $3 $4 $5 $6" >> file.txt ;clear
      echo "$1 detail added successfully";echo
      echo -en "add another (y/n): ";read res
      if [[ "YES" == *"${res^^}"* ]];then 
         echo "Add another profile";accept
      else clear; main
      fi  
   else
      echo "$1 already existed"
      echo ;echo ;exit
   fi 
   }

   
edit(){
   clear;echo "    Edit $1"
   ll=(Name Surname Email Telphone Age Address)
   echo "1)${ll[0]}      (2)${ll[1]}   (3)${ll[2]} 
4)${ll[3]}  (5)${ll[4]}     (6)${ll[5]}";echo
   echo -en "choose : ";read i
   while ! [[ "123456" == *"${i}"* ]]
      do
        echo -en "invalid choose again : "
        read i
      done
   echo -en "Update ${ll[`expr $i - 1`]}: ";read ans
   val=`grep -ic $1 file.txt`
   if ! [ $val -eq "0" ];then
      file="file.txt" ;touch temp.txt;temp="temp.txt"
      while IFS= read -r line
        do
          if [[ ${line^^} == *"${1^^}"* ]];then
             if [ $i -le "5" ];then
                 dtl=(${line[@]}) ;dtl[`expr $i - 1`]=$ans
                 echo ${dtl[@]} >> $temp;continue
             else
               dtl=(${line[@]})
               echo "${dtl[0]} ${dtl[1]} ${dtl[2]} ${dtl[3]} ${dtl[4]} $ans" >> $temp;continue
             fi
          fi
          echo $line >> $temp
        done < $file
     rm file.txt; mv temp.txt file.txt
     echo "${1^^} (${ll[`expr $i - 1`]}) Updated successfully" 
     echo -en "continue....";read i;main
        
   else
      echo "$1 Not exist"
      echo -en "Did you want to Add $1 (y/n): ";read res
      if [[ "YES" == *"${res^^}"* ]];then 
        clear;"  Enter $1 profile"; accept 
      else
        clear ;main
      fi
   fi
} 
       
   
   
search() {
   num=`grep -iwc $1 file.txt`
   if ! [ $num -eq "0" ];then
      res=(`grep -i $1 file.txt`);
      clear ;echo ; echo "      Search FOUND"
      echo Name: ${res[0]};
      echo Surname: ${res[1]};
      echo Email: ${res[2]};
      echo Tel_Phone: ${res[3]};
      echo Age: ${res[4]};
      echo Address: ${res[@]:5};echo
      echo -en "Did you want to edit $1 profile (y/n) : ";
      read val
      if [[ "YES" == *"${val^^}"* ]];then 
         clear;"    Edit $1 profile";edit $1
      else 
        clear; main
      fi
      
   else
      echo ;echo "$1 Not found"
      echo -en "Did you want to add $1 (y/n): ";read yes
      if [[ "YES" == *"${yes^^}"* ]];then 
         clear;e"   Add $1 profile";echo;accept;
      else
         clear;main
      fi
   fi
   }
   
remove() {
   val=`grep -iwc $1 file.txt`
   if [ $val -ge "1" ];then
      file='file.txt' ;touch temp.txt ;temp="temp.txt"
      while IFS= read -r line
        do 
           dst=(${line[@]})
           echo "${1^^} == ${dst[0]^^}"
           if [ ${1^^} == ${dst[0]^^} ];then
              echo "removing $1 details...";continue
           fi
        echo $line >> $temp
        done < $file
      rm file.txt;mv temp.txt file.txt
      echo "$1 detail Remove successfully"
      echo -en "continue .... ";read i
      main
   else
      echo "$1 don't exist"
      echo -en "Did you want to Retry (y/n): ";read try
      if [[ "YES" == *${try^^}* ]];then
         clear;echo "    remove another"
         echo -en "Enter profile (Name): ";read name
         remove $name
      else
         main
      fi
   fi
    

}
   
list() {
    file='file.txt';num=1
    while IFS= read -r line
       do
          dst=(${line[@]})
          echo "($num) ${dst[0]}" ;num=`expr $num + 1`
       done < $file
    echo -en "continue.... ";read i;main
}
   
accept(){
    echo -en "Enter (Name): ";read name
    echo -en "Enter (Surname): ";read Sname
    echo -en "Enter (Email): ";read email
    echo -en "Enter (Telephone): ";read Tel
    echo -en "Enter (Address): ";read adrs
    echo -en "Enter (Age):: ";read age 
    if ! [ "$name" == "" ];then
       add "$name" "$Sname" "$email" "$Tel" "$age" "$adrs"
    else
       clear ;echo ; echo "enter details" ;accept
    fi
    }
 

main(){
     clear
     echo "#######WelCome To Abdultahmon Addressbox##########"
     echo "#############linuxshell Exercise#############";echo
     select i in Add Remove Search Edit Data Quit
     do
       case $i in 
         Add)   accept;;
        Remove) 
          clear;echo "   Remove"
          echo -en "Enter profile (Name): ";read name
          remove $name;;
        Search) 
          clear;echo "    Search"
          echo -en "Enter profile (Name): ";read name
          search $name;;
        Edit) 
          echo -en "Enter profle (Name): ";read name
          edit $name ;;
        Data)
           echo "   profiles data"
           list;;
        Quit) 
          echo quiting...
          exit  ;;
        *) 
         echo `clear`
             "Invalid input"
             main ;;
      esac
    done }
    
main































