@echo off
echo Running 7-Zip demo sequence
call demo_compress\compress.bat
call demo_list\list_contents.bat
call demo_hash\hash.bat
call demo_extract\extract.bat
call demo_search\search_by_name.bat
echo Demo sequence complete.
pause
