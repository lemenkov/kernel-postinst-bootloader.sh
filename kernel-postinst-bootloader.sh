#!/bin/sh


[ -f /etc/sysconfig/kernel ] && . /etc/sysconfig/kernel

version="$1"

machine_id=
if [ -f /etc/machine-id ]; then
	machine_id="$(cat /etc/machine-id)"
fi

title="Default OS ($version)"
if [ -f /etc/os-release ]; then
	title="$(grep -o -P "(?<=PRETTY_NAME=\")(.*)(?=\")" /etc/os-release) ($version)"
fi

os_id="$(echo "$title" | tr 'A-Z' 'a-z' | cut -d' ' -f1)"
if [ -z "$os_id" ]; then
	os_id=linux
fi

conffile="/boot/loader/entries/${machine_id+${machine_id}-}${os_id}-${version}.conf"

touch ${conffile}
echo "title   ${title}" >> ${conffile}
echo "version ${version}" >> ${conffile}
echo "machine-id ${machine_id}" >> ${conffile}
echo "options ${DEFAULTCMDLINE}" >> ${conffile}
echo "linux   /vmlinuz-${version}" >> ${conffile}
echo "initrd  /initramfs-${version}.img" >> ${conffile}
