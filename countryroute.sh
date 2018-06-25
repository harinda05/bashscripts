#!/bin/bash
#set -xv
#author - P.H.Samarasekara
#index - 15020657
#reg - 2015/IS/065

maxttl=64

echo -e "<Hop#>"'\t''\t'"<RTT>"'\t''\t'"<Country>"'\t''\t'"<IP>"'\t''\t'"<Domain>"

for (( i=1; i<=maxttl; i++ ))
do
	
	m_ip="$(ping -c 1 $1 -n|grep -o '[0-9]\{0,3\}\.[0-9]\{0,3\}\.[0-9]\{0,3\}\.[0-9]\{0,3\}'|tail -1)" #getting target ip
	ip="$(ping -c 1 -t $i $1 -n|grep 'icmp_seq'|grep -o '[0-9]\{0,3\}\.[0-9]\{0,3\}\.[0-9]\{0,3\}\.[0-9]\{0,3\}'|tail -1)" #getting hop ip

	#getting the country
	

	country=$(whois $ip|grep -E '[Cc]ountry'|awk '{print $2}'|head -1)
	avg_rtt=$(ping -c 3 $ip|grep rtt|cut -d"/" -f5)
	domain=$(dig -x $ip +short)

  #----------- Start Print Constraints ------------#

	#constraints when ip is null

	if [ -z "$ip" ]
	then
		ip='*'
		country='*'
		avg_rtt='*'
		domain='*'
	fi
		ip=$ip
		country=$country
		avg_rtt=$avg_rtt
		domain=$domain


	#constraints when country is null

	if [ -z "$country" ]
	then
		country='*'
	fi
		country=$country


	#constraints when avg_rtt is null

	if [ -z "$avg_rtt" ]
	then
		avg_rtt='*'
	fi
		avg_rtt=$avg_rtt


	#constraints when domain is null

	if [ -z "$domain" ]
	then
		domain='*'
	fi
		domain=$domain

   #----------- End Print Constraints ------------#

	#Stop loop and start printing the results

	if [ "$m_ip" == "$ip" ]

	then	
		echo -e "[$i]"'\t''\t'"$avg_rtt"'\t''\t'"$country"'\t''\t'"$ip"'\t''\t'"$domain"
		break
	fi
		
		echo -e "[$i]"'\t''\t'"$avg_rtt"'\t''\t'"$country"'\t''\t'"$ip"'\t''\t'"$domain"
	
done



