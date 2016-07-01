#!/bin/bash

machine=(
"10.48.162.5"
"10.126.92.6"
"10.126.102.9"
"10.126.92.10"
"10.126.90.16"
"10.126.102.18"
"10.48.144.19"
"10.126.90.20"
"10.126.101.23"
"10.126.90.28"
"10.126.90.35"
"10.48.144.37"
"10.48.144.43"
"10.126.84.66"
"10.48.184.73"
"10.126.101.88"
"10.5.18.111"
"10.5.18.112"
"10.48.184.150"
"10.48.184.156"
"10.126.92.164"
"10.126.101.195"
"10.126.89.204"
"10.126.89.208"
"10.126.91.223"
"10.126.101.224"
"10.126.86.230"
"10.126.91.230"
"10.126.86.231"
"10.126.86.232"
"10.126.86.233"
"192.168.118.33"
"192.168.119.62"
"192.168.117.70"
"192.168.119.110"
"192.168.119.121"
"192.168.118.123"
"192.168.120.157"
"192.168.120.171"
"192.168.119.175"
"192.168.119.179"
"192.168.120.187"
)

function printAll(){
	num=${#machine[@]}
	size=6
	row=$((num/size + (num%size>0?1:0)))
	echo `cstr 37 "-----------------"`
	echo `cstr 33 "Listing Machine : "`
	echo `cstr 37 "-----------------"`
	echo ""
	for((i=0;i<$row;i++))
	do
		templ=""
		for((j=0;j<$size;j++))
		do
			idx=$((i*size+j))
			if (( $j == 0 ));then
				templ="    %-2s>%-16s"
			elif (( $idx < $num ));then
				templ=$templ"  %-2s>%-16s"
			fi
		done
		templ=$templ"\n\n"
		values=""
		for((j=0;j<$size;j++))
		do
			idx=$((i*size+j))
			d=`cstr 33 $((idx+1))`
			if (( $j == 0 ));then
				values=$d" "${machine[idx]}
			elif (( $idx < $num ));then
				values=$values" "$d" "${machine[idx]}
			fi
		done
		printf "$templ" $values
	done
	echo "------------------"
}

function cstr(){
#echo $2
echo "\033[$1m$2\033[0m"
}

function readIn(){
	read -p "`cstr 33 "Enter Machine No : "`" no
	if (( $no == 0 )) 
	then
		delknhosts
		echo "[INFO] remove hosts relay.58corp.com success!"
		run
	else
		goMachine $((no-1))
	fi
}

function goMachine(){
	echo "go Machine "${machine[$1]}
	echo $shellpath"/"relay58.py
	python2.6 $shellpath"/"relay58.py zhoulinhong relay.58corp.com ****** ${machine[$1]}
}

function run(){
	printAll
	readIn
}

shellpath="/Users/alen/Documents/myshell"
run
