@ echo off
echo open 192.168.1.181>>__upload_dump_.dat
echo wxsj2>>__upload_dump_.dat
echo 123456>>__upload_dump_.dat
echo put %1>>__upload_dump_.dat
echo bye>>__upload_dump_.dat
ftp -v -s:__upload_dump_.dat
del __upload_dump_.dat 
