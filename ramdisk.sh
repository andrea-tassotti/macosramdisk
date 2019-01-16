#!/bin/bash 
#
#	Copy this file in ~/Library/LaunchAgents/dom.mydomain.ramdisk.plist
#
#	Andrea Tassotti
#

SIZE="${1:-512}"
BLOCKS=$( echo "$SIZE * 2048" | bc )
# DEBUG echo "Make ${SIZE}MB ($BLOCKS blocks) volume ... "
DISK="$( hdiutil attach -nomount ram://$BLOCKS )"
if test -n $DISK
then
	diskutil erasevolume HFS+ 'RAMDisk' $DISK
	diskutil mount $DISK
fi

# Content of ramdisk.plist:
#
#{
#	Label = "dom.mydomain.ramdisk";
#	OnDemand = NO;
#	LaunchOnlyOnce = YES;
#	ProgramArguments = (
#		"/Users/andrea/ramdisk.sh",
#		300,
#	);
#}
#
#	Add this key for System wide installation instead of per-user:
#
#	#	UserName = andrea;
#	#	GroupName = wheel;
#