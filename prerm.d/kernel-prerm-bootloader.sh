#!/bin/bash

# Copyright (c) 2013 Alexey I. Froloff <raorn@raorn.name>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

[ -f /etc/sysconfig/kernel ] && . /etc/sysconfig/kernel

version="$1"

machine_id=
if [ -f /etc/machine-id ]; then
	machine_id="$(cat /etc/machine-id)"
fi

os_id="$(echo "$title" | tr 'A-Z' 'a-z' | cut -d' ' -f1)"
if [ -z "$os_id" ]; then
	os_id=linux
fi

conffile="/boot/loader/entries/${machine_id+${machine_id}-}${os_id}-${version}.conf"

rm -f "${conffile}"
