Copy all the files to the build directory.
Copy icudtl.dat to the build directory. (you can find it in the vscode downloads ex for linux).
chromium version in port is 52.0.2743.116.
This was built with FreeBSD 11.0-RELEASE-p1. If building with other versions probably need to change
the freebsd versions in diff files (ex. freebsd11 => freebsd10)
Installed 
node => v6.9.1
npm => 3.9.2

>chmod 755 vscode_build.sh
>./vscode_build.sh

VSCODE should not be built as root, or npm will fail.

Changes:
12/10/2016 - made changes to electronv1.diff <atom/common/node_bindings_linux.cc>
13/10/2016 - electronv1.diff <script/lib/config.py, script/create-dist.py>
2/11/2016 - vscodev1.diff <src/vs/base/common/platform.ts, src/vs/editor/contrib/selectionClipboard/electron-browser/selectionClipboard.ts>