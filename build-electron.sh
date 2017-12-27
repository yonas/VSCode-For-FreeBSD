#!/usr/local/bin/bash

set -e

export BUILDROOT=`pwd`
set -x
svnlite co -r442282 svn://svn.freebsd.org/ports/head/www/chromium chromium
cd chromium
rm files/patch-gpu_command__buffer_service_program__manager.cc files/patch-gpu_config_gpu__control__list.cc files/patch-third__party_leveldatabase_env__chromium.cc
patch -p1  --ignore-whitespace < ../chromium-Makefile.diff
make configure DISABLE_VULNERABILITIES=yes
cd ..
if [ ! -d "libchromiumcontent" ]; then
    git clone https://github.com/electron/libchromiumcontent.git
fi
cd libchromiumcontent
git checkout e301597
patch -p1  < ../libchromiumcontent.diff 
script/bootstrap
mv ../chromium/work/chromium-58.0.3029.110 src
mv src/third_party/ffmpeg/BUILD.gn.orig src/third_party/ffmpeg/BUILD.gn
patch -p1  --ignore-whitespace -d src/ < ../chromiumv1.diff
script/update -t x64
script/build --no_shared_library -t x64
script/create-dist -c static_library -t x64

# Building ELECTRON ...
echo "Building ELECTRON ..."
cd $BUILDROOT
if [ ! -d "electron" ]; then
    git clone https://github.com/electron/electron.git
fi
cd electron/
git checkout v1.7.7
patch  -p1 --ignore-whitespace < ../electronv3.diff
set +e
# this will fail when it tries to download libchromiumcontent library
script/bootstrap.py -v --clang_dir=/usr
set -e
patch  -p1  --ignore-whitespace -d vendor/native_mate/  < ../electron_vendor_native_matev1.diff
patch  -p1  --ignore-whitespace -d brightray/  < ../electron_brightrayv3.diff
patch  -p1  --ignore-whitespace -d vendor/libchromiumcontent/  < ../electron_vendor_libchromiumcontentv1.diff
patch  -p1  --ignore-whitespace < ../electron_node_modules.diff
mkdir vendor/download/libchromiumcontent
unzip ../libchromiumcontent/libchromiumcontent.zip -d vendor/download/libchromiumcontent/
unzip ../libchromiumcontent/libchromiumcontent-static.zip -d vendor/download/libchromiumcontent/
script/bootstrap.py -v --clang_dir=/usr
script/build.py -c R
script/create-dist.py
