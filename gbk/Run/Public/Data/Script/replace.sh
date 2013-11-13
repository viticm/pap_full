#!/bin/sh
#author: viticm<viticm@126.com>
#date: 2013-11-13 14:33:52
#desc: just for lua up from ver4 to ver5
lua_files=`find ./ -type f -name "*.lua"`

#find the need relpace lua files
find_cmd="grep -n 'for '| grep -v pairs | grep ' do' | grep 'in ' | awk -F ':' '{print \$1}'"
for luafile in ${lua_files}
do
    find_lines=`echo "cat ${luafile} | ${find_cmd}" | sh`
    for line in ${find_lines}
    do
        echo "find in file: ${luafile}, line: ${line}, relpace it"
        sed -i "${line}s/in /&pairs(/g;${line}s/ do/)&/g" ${luafile}
    done
done
