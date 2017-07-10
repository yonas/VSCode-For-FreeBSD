This is port of Electron and VSCode for Freebsd.

This was built with FreeBSD 11.0-RELEASE-p1.  
    Chromium version in port is 52.0.2743.116.  
    Electron version => 1.3.7  
    VSCode version => 1.7.0  
    
If building with other FreeBSD versions  need to change  
the freebsd version in diff files (ex. freebsd11 => freebsd10)

To build copy all the files to the build directory.  
Copy icudtl.dat to the build directory. (you can find it in the vscode downloads, ex for linux).

>chmod 755 vscode_build.sh

>./vscode_build.sh

VSCODE should not be built as root, or npm will fail.


TO RUN VSCODE :
> setenv LD_LIBRARY_PATH \[VSCODE FOLDER LOCATION\] 

(example for tcsh > setenv LD_LIBRARY_PATH /usr/home/xyz/VSCode-freebsd-x64/)

(example for bash > export LD_LIBRARY_PATH=/usr/home/xyz/VSCode-freebsd-x64/)

> ./code-oss

**Microsoft C/C++ and C# extensions**  
This extentions only work with v1.10 and require  linux compatiblity layer (for c extention) and Mono installed.   
The centos library *linux_base-f7* in FreeBSD port does not work (but needs to be installed) with the extensions.  
**vcode_ext_linux_debian8.tar.gz** contains the required linux libraries from debian 8.    
Extract this to /compact/linux/usr/.  
Extract the extenions **vscode_C_CS_extention.tar.gz** to ~/.vscode/extentions/.   
Load linux compatibility module
> kldload linux64

Install xterm and create a symlink for it in /usr/bin/xterm
> ln -s /usr/local/bin/xterm /usr/bin/xterm 

Install mono-debug extention for c# debugging from vscode.  
Dotnet debugging is not possible.  
**vcode_example_ext.tar.gz** is a example vscode projects for c and c#.

21/06/2017:

Binaries for VSCODE 1.10, VSCODE 1.7, ELECTRON 1.3.7  
Compiled with ICU 58, , LIBCHROMIUM 52.0.2743.116

10/07/2017:

Binaries for Microsoft extentions for C and C#.  
Linux library used with the extentions.  
Example projects for c and c#.
