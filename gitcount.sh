#!/bin/bash

echo -n "Enter github organization/repository[/revision] to count: "
IFS=/ read org repo rev extra
if [ -z "$org" -o -z "$repo" ] ; then
    echo "Sorry, you must specify at least an organization and revision"
    exit 1
fi
rev=${rev:-master}
loc=${org}/${repo}
rm -rf ${loc}
mkdir -p ${loc}
echo Git clone of ${org}/${repo}, branch or revision: $rev
git clone https://github.com/${org}/${repo} -b ${rev} ${loc}
wc $(find ${loc} -type f)
