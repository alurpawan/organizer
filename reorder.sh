#!/bin/bash
#A script the reorders the list of files in a folder



#Input for which action is to be taken(Organize or Undo)
echo "Enter 1 for Organize and 2 for Undo Organize : "
read choice

#First Choice
if [ $choice == 1 ]
then
    #Input for location to organize
    echo "Enter the path of the folder to Organize : "
    read location

    #GOTO location
    cd $location
    
    if [ -f "orig_name.txt" ]                                  #Check if file(orig_name.txt) aldready exists to avoid repition
    then
	echo "Aldready done reordering"                        #Inform that aldready done reordering once 
    else
	ls | grep -v "orig_name.txt" >> orig_name.txt
	ep_no=1

	#Loop for all elements in the file(orig_name.txt)
	cat orig_name.txt |  while read LINE
	do
	    echo "Episode "$ep_no" : "$LINE                    #Display episode number corresponding to each existing name(also to detect errors)
	    mv $LINE "Episode$ep_no.mp4"                       #Rename using mv
	    ep_no=$((ep_no+1))                                 #Increment episode number
	done
    fi

#Second Choice
elif [ $choice == 2 ]
then
    echo "Enter the path of the folder to undo changes"
    read location
    cd $location

    #GOTO location
    if [ -f "orig_name.txt" ]
    then
	ep_no=1
	#Looping based on orig_name.txt
	cat orig_name.txt | while read LINE
	do
	    echo "Episode "$ep_no" : "$LINE                  #Display episode number corresponding to each existing name(also to detect errors)
	    mv "Episode$ep_no.mp4" $LINE                     #Rename using mv
	    ep_no=$((ep_no+1))                               #Incement episode number
	    
	done
	rm orig_name.txt                                 #Remove orig_name to allow reorganizing
    else
	echo "This folder is not organized"
	fi
#If invalid input entered
else
    echo "Please enter valid input"
fi
