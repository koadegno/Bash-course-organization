#!/bin/bash

create_university()
{
	# this function create University directory and
	# all the sub directory 
	
	if [ -d "University" ] #University existe ?
	then
	
		rm -r "University"
	fi
		
	mkdir "University"
	for (( i=0; i < ${#courses[@]}; i++ ))
	do
	
		if [ -d ${courses[i]} ] # TODO change this q1
		then
			rm -r ${courses[i]}
		fi
		
		mkdir ${courses[i]} | cut -c 1-9 # choose to keep only the usefull things
		
		echo $( echo ${courses[i]} | cut -c 1-9 ) "create"
		 
		
	done
	
	echo
	echo "All files creates succefuly"
	echo
	
	rm -r *
}


main()
{

	
	local courses=($( cat "$1" )) # put the result of cat in courses arrays
	cd $3
	
	create_university # call function
	}



if [[ $# -eq 3 && -e "$1" && -d "$2" && -d "$3" ]]
then
	
	main $1 $2 $3
		
else
	echo
	echo  "Structure de l'appel du script non respecter "
	echo

fi

