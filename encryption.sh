#!/bin/bash

# Swapping function
# Parameters:
# $1 - key to be swapped
# Returns:
#    Swapped key
swap(){
	key=$1
	len=${#key}
	for (( i=0; i<$len; i=i+2 ))
	do
		s1=$( echo ${key:$i:1} )
		s2=$( echo ${key:$i+1:1} )
		out=$out$s2$s1
	done
	echo $out | tr '[:upper:]' '[:lower:]'
}

# No parameters
# Shows UI
if (( "$#" == 0 ));
then
	echo "Message: "
	read msg
	echo "Key: "
	read key
	s=$( swap $key )
	echo $msg | tr '[:upper:]' '[:lower:]' | tr $key $s
fi

# 1 parameter - key
# Use with pipe
# Example:
#    cat msg | ./encryption.sh gaderypoluki
if (( "$#" == 1 ));
then
	input=""
	while read LINE; do
		input=$input$LINE
	done < /dev/stdin

	s=$( swap $1 )
	echo $input | tr '[:upper:]' '[:lower:]' | tr $1 $s
fi

# 2 parameters - message and key
if (( "$#" >= 2 ));
then
	s=$( swap $2 )
	echo $1 | tr '[:upper:]' '[:lower:]' | tr $2 $s
fi
