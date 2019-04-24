*cmake*                     Cmake, C, Cpp Project builder

	This help aims to explain some cmake commands lines, functions and
	examples 

 	For examples :   
		D:\Software\Formation\01_12_Cmake1\Cmake\CMakeLists.txt
		D:\Doc\cmake\html\index.html 

	Usually, I put 4 directories : 
		bin/ 	Will contains the binaries to execute
		src/ 	Caintains .c and .h files, this is the directory to edit
		build/	Contains the VS files and from here I compile 
		deps/	Out Lib, caintains external dependancies
		CMakeLists.txt With the rules of building


add_library
add_executable
add_test
target_include_directory
traget_compile_options
project
add_custom_command

================================================================================
                                                  *mcmake-commands*
cmake-commands ~
>bash
	cd build
	cmake --build . --config release
	cmake .. -G "NMake Makefiles" # To create and nmake file dans build I can compile then with nmake 
	nmake /help # in windows to get help 
    -DCMAKE_BUILD_TYPE=Relase
<bash	


================================================================================
                                                  *mcmake-test*
cmake-test ~
	Test must return 0 in case of succes 

	enable_testing() 
	add_test(test mytest) 
	add_custom_command(TARGET mytest POST_BUILD COMMAND mytest ARGS arg1 arg2) # this will execute mytest after it is build  


================================================================================
                                                  *mcmake-stack*
cmake-stack ~
	cmake: fatal error cannot open x.lib or x.exp 
		-> use the __declspec(dllexport), because the dyanmic librairy
		has no export
		-> See LoadLibrairy instead of target_link_librairies

	add_compile_options(-Wall) 

	Cmake choose the config release or debug and archi. 
	Todo, change archi 

vim: ft=myhelp
