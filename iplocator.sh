#!/bin/bash

for i in `awk '{print $1}' access.log|uniq`

do
	info=$(whois $i|grep -E 'country'|sed -r 's/.*(.{3})/\1/')
	echo "$i:$info"
done
