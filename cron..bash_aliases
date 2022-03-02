#!/bin/bash

snap_prefix=snap

#number of snapshots which can be made(whichever becomes 4th gets deleted) 
retention=3

#variables
src_0="new-pool/dataset1"
today="$snap_prefix-`date +%H:%M`"
snap_today="$src_0@$today"
snap_old=`zfs list -t snapshot -o name | grep "$src_0@$snap_prefix*" | sort -r | sed 1,${retention}d | xargs -n 1`
 
#if snapshot doesnt exist, create it
if zfs list -H -o name -t snapshot | grep "$snap_today" > /dev/null
then
	echo "Snapshot already exists"
else
	zfs snapshot -r $snap_today
fi
 
#if snapshot is older than $retention destroy it
if [ -n "$snap_old" ]
then
	zfs list -t snapshot -o name | grep "$src_0@$snap_prefix*" | sort -r | sed 1,${retention}d | xargs -n 1 zfs destroy -r
else
	echo "No snapshot to destroy"
fi
 
