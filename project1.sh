#!/bin/bash

create_university()
{
	# this function create University directory and
	# all the sub directory 
	
	if [ -d "University" ] #University exist ?
	then
	
		rm -r "University"
	fi
		
	mkdir "University"
	destination=$destination"/University"
	cd $destination
	
	for (( i=0; i < ${#courses[@]}; i++ )) #
	do
		tmp=${courses[i]}
		tmp=${tmp:0:9}
		courses[i]=$tmp
		if [ -d ${courses[i]} ] # TODO change this q1
		then
			rm -r ${courses[i]}
		fi
		
		

		mkdir ${courses[i]} 
		
		echo "- ${courses[i]} crée"
		#echo ${courses[@]}
		
	done
	
	
}

main()
{

	
	courses=($( cat "$courses" )) # put the result of cat in courses arrays
	cd $destination
	
	create_university # call function
	echo
	#echo $( ls - grep ${courses[0]} )

	# grep -o -i -r -n -e $var -e "info-f102" test_files/
	# TODO cest la commande pour avoir les FICHIER qui INLCUDE le mot que tu cherches

	#	find test_files -iname *$var*
	#	fait la meme chose avec les fichiers ONT le mot DANS LEURS NOMS
	
}



if [[ $# -eq 3 && -f "$1" && -d "$2" && -d "$3" ]]
then
	if [[ -r "$1" ]]
	then

		courses="$1"
		source="$2"
		destination="$3"

		
		[[  ${destination:0:1} != "/" ]] && destination="$PWD"/"$destination"
		[[  ${source:0:1} != "/" ]] && source="$PWD"/"$source"

		echo
		echo "- fichier     : $courses "
		echo "- source      : $source "
		echo "- destination : $destination "
		echo

		main
	
	else
		echo
		echo "Pas la permission de lire "
		echo
	
	fi
else
	echo
	echo  "Structure de l'appel du script non respecter  !!! "
	echo

fi

