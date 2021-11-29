#!/bin/bash
for ((i=1; i <= 100; i++))
do
	echo "prepare read test"
	sh -c "sync && echo 3 > /proc/sys/vm/drop_caches" #clean Buffer
	sudo dd if=/dev/sda of=/dev/null bs=1M count=300 iflag=direct status=progress
	echo "read successfully"

	echo "prepare write test"
	sh -c "sync && echo 3 > /proc/sys/vm/drop_caches" #clean Buffer
	sudo dd if=/dev/zero of=/home/ljc/test.txt bs=1M count=100 oflag=direct status=progress #/home/ljc: the disk is hung in the path
	echo "write successfully"
	rm /home/ljc/test.txt
	echo $i 
	echo 
done

