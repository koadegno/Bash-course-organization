#!/bin/bash

# 25/10/2020
# Adegnon Kokou Vinove
# 501910

create_university()
{
	# this function create University directory and
	# all the sub directory 
	
	if [ -d "University" ] #University exist ?
	then
	
		rm -r "University"
	fi
		
	mkdir "University"
	destination=$destination"University/"
	cd $destination
	touch log.txt
	
	for (( i=0; i < ${#courses[@]}; i++ )) # until i == |courses|
	do
		
		if [ -d ${courses[i]} ] # if the sub directory exist 
		then
			rm -r ${courses[i]}
		fi
		mkdir ${courses[i]} 
		echo "- ${courses[i]} crée" 
		
		
	done
	echo
}

find_and_mv_files(){
	# function to search all occurence of data in $courses( an arrays of courses) and
	# copy that occurence in dest
	# param : $1 = source, where to do the search
	# param : $2 = destination, where to copy the founded file 

	src=$1
	dest=$2
	#lim=${#dest}

	for to_search in ${courses[*]} # iterate on all the arrays 
	do
		dest=$dest$to_search # get the right acces to the copy place

		# xargs is to use the input in a specific place		
		# find file with to_search in the name and write in tmp.txt
		find $src  -iname *$to_search* | xargs -i echo  "FROM "{}" TO "$dest" " > tmp.txt 
		
		# find file with to_search inside cut to get the right field and write in tmp.txt 
		grep -o -i -r -e $to_search $src | cut -d ':' -f1 | xargs -i echo  "FROM "{}" TO "$dest" " >> tmp.txt

		# from the tmp.txt just cut, get the right field and copy to dest 
		cut  -d " " --fields 2  tmp.txt | xargs  -i cp "{}" $dest

		# move the content in tmp.txt inside log_file
		echo "- Fichiers copiés, log mis à jour pour $to_search"
		cat tmp.txt >> $log_file

		dest=$2
		
	done

	rm tmp.txt #deleting the tmp file
}

main()
{
	courses=($( cat "$courses" )) # put the result of cat command in courses arrays
	cd $destination
	
	create_university # call function
	cd ..
		
	find_and_mv_files $source $destination # give param to the function
	
}

if [[ $# -eq 3 && -f "$1" && -d "$2" && -d "$3" ]]
then
	if [[ -r "$1" ]]
	then

		courses="$1"
		source="$2"
		destination="$3"
		

	
		[[  ${destination:0:1} != "/" ]] && destination=$PWD"/"$destination
		[[  ${source:0:1} != "/" ]] && source=$PWD"/"$source

		[[  ${destination:${#destination}-1:${#destination}} != "/" ]] && destination=$destination"/"
		[[  ${source:${#source}-1:${#source}} != "/" ]] && source=$source"/"

		log_file=$destination"/University/log.txt"

		echo
		echo "- Fichier     : $courses"
		echo "- Source      : $source"
		echo "- Destination : $destination"
		echo "- Log file    : $log_file"
		echo

		main # call main function

		echo
		echo "END"
		echo

		exit 0
	
	else
		echo
		>&2 echo  "Pas la permission de lire " 
		echo

		exit 1
	fi
else
	echo
	>&2 echo  "Structure de l'appel du script non respecter !"
	echo
	
	exit 1
		
fi

