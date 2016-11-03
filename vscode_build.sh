#!/usr/local/bin/bash

set -e

export BUILDROOT=`pwd`
set -x

#Building LIBCHROMIUMCONTENT ...
echo "Building LIBCHROMIUMCONTENT ..."
sudo make -C /usr/ports/www/chromium/ configure
git clone https://github.com/atom/libchromiumcontent.git
cd libchromiumcontent/
git checkout c5cf295ef9
cd vendor/python-patch/
git submodule update --init --recursive
cd ../../
patch -p1  < ../libchromiumcontent.diff
ln -s /usr/ports/www/chromium/work/chromium-52.0.2743.116/ src
set +e
sudo rm src/base/process/launch.cc.orig
sudo rm src/content/app/content_main_runner.cc.orig
sudo rm src/chrome/chrome_resources.gyp.orig
rm -rf patches/third_party/icu/
set -e
sudo script/apply-patches
sudo cp -R chromiumcontent/ src/chromiumcontent
sudo patch -p1  -d src/ < ../libchromiumcontent_src.diff
sudo rm -rf src/out/
cd src
sudo /usr/bin/env CC="cc"  CXX="c++"  GYP_GENERATORS=ninja  GYP_GENERATOR_FLAGS="output_dir=out" GYP_DEFINES="clang_use_chrome_plugins=0  component=static_library  linux_breakpad=0  linux_use_heapchecker=0  linux_strip_binary=1  use_aura=1  mac_mas_build=1 test_isolation_mode=noop  disable_nacl=1  enable_extensions=1  enable_one_click_signin=1  enable_openmax=1  enable_webrtc=1  werror=  no_gc_sections=1  OS=freebsd  os_ver=1100122  prefix_dir=/usr/local  python_ver=2.7  use_allocator=none  use_cups=1  linux_link_gsettings=1  linux_link_libpci=1  linux_link_libspeechd=1  libspeechd_h_prefix=speech-dispatcher/  usb_ids_path=/usr/local/share/usbids/usb.ids  want_separate_host_toolset=0  use_system_bzip2=1  use_system_flac=1  use_system_harfbuzz=1  use_system_icu=1  use_system_jsoncpp=1  use_system_libevent=1  use_system_libexif=1  use_system_libjpeg=1  use_system_libpng=1  use_system_libusb=1  use_system_libwebp=1  use_system_libxml=1  use_system_libxslt=1  use_system_nspr=1  use_system_protobuf=0  use_system_re2=1  use_system_snappy=1  use_system_speex=1  use_system_xdg_utils=1  use_system_yasm=1  v8_use_external_startup_data=1  google_api_key=AIzaSyBsp9n41JLW8jCokwn7vhoaMejDFRd1mp8  google_default_client_id=996322985003.apps.googleusercontent.com  google_default_client_secret=IR1za9-1VK0zZ0f_O8MVFicn ffmpeg_branding=Chrome proprietary_codecs=1 use_gconf=1 use_pulseaudio=0 clang=1" ac_cv_path_PERL=/usr/local/bin/perl ac_cv_path_PERL_PATH=/usr/local/bin/perl PKG_CONFIG=pkgconf PYTHON="/usr/local/bin/python2.7" AR=/usr/bin/ar CFLAGS="-O2 -pipe  -isystem/usr/local/include -I/usr/local/include/atk-1.0 -Wno-unknown-warning-option -D_LIBCPP_TRIVIAL_PAIR_COPY_CTOR=1 -fstack-protector -fno-strict-aliasing"  CPPFLAGS=""  CXXFLAGS="-O2 -pipe -isystem/usr/local/include -I/usr/local/include/atk-1.0 -Wno-unknown-warning-option -D_LIBCPP_TRIVIAL_PAIR_COPY_CTOR=1 -fstack-protector -fno-strict-aliasing "  LDFLAGS=" -fstack-protector" XDG_DATA_HOME=/usr/ports/www/chromium/work  XDG_CONFIG_HOME=/usr/ports/www/chromium/work  HOME=/usr/ports/www/chromium/work SHELL=/bin/sh CONFIG_SHELL=/bin/sh /usr/local/bin/python2.7  build/gyp_chromium --depth . -Ichromiumcontent/chromiumcontent.gypi chromiumcontent/chromiumcontent.gyp
sudo /usr/bin/env CC="cc"  CXX="c++"  GYP_GENERATORS=ninja  GYP_GENERATOR_FLAGS="output_dir=out_component" GYP_DEFINES="clang_use_chrome_plugins=0  component=shared_library  linux_breakpad=0  linux_use_heapchecker=0  linux_strip_binary=1  use_aura=1  mac_mas_build=1 test_isolation_mode=noop  disable_nacl=1  enable_extensions=1  enable_one_click_signin=1  enable_openmax=1  enable_webrtc=1  werror=  no_gc_sections=1  OS=freebsd  os_ver=1100122  prefix_dir=/usr/local  python_ver=2.7  use_allocator=none  use_cups=1  linux_link_gsettings=1  linux_link_libpci=1  linux_link_libspeechd=1  libspeechd_h_prefix=speech-dispatcher/  usb_ids_path=/usr/local/share/usbids/usb.ids  want_separate_host_toolset=0  use_system_bzip2=1  use_system_flac=1  use_system_harfbuzz=1  use_system_icu=1  use_system_jsoncpp=1  use_system_libevent=1  use_system_libexif=1  use_system_libjpeg=1  use_system_libpng=1  use_system_libusb=1  use_system_libwebp=1  use_system_libxml=1  use_system_libxslt=1  use_system_nspr=1  use_system_protobuf=0  use_system_re2=1  use_system_snappy=1  use_system_speex=1  use_system_xdg_utils=1  use_system_yasm=1  v8_use_external_startup_data=1  google_api_key=AIzaSyBsp9n41JLW8jCokwn7vhoaMejDFRd1mp8  google_default_client_id=996322985003.apps.googleusercontent.com  google_default_client_secret=IR1za9-1VK0zZ0f_O8MVFicn ffmpeg_branding=Chrome proprietary_codecs=1 use_gconf=1 use_pulseaudio=0 clang=1" ac_cv_path_PERL=/usr/local/bin/perl ac_cv_path_PERL_PATH=/usr/local/bin/perl PKG_CONFIG=pkgconf PYTHON="/usr/local/bin/python2.7" AR=/usr/bin/ar CFLAGS="-O2 -pipe  -isystem/usr/local/include -I/usr/local/include/atk-1.0 -Wno-unknown-warning-option -D_LIBCPP_TRIVIAL_PAIR_COPY_CTOR=1 -fstack-protector -fno-strict-aliasing"  CPPFLAGS=""  CXXFLAGS="-O2 -pipe -isystem/usr/local/include -I/usr/local/include/atk-1.0 -Wno-unknown-warning-option -D_LIBCPP_TRIVIAL_PAIR_COPY_CTOR=1 -fstack-protector -fno-strict-aliasing "  LDFLAGS=" -fstack-protector" XDG_DATA_HOME=/usr/ports/www/chromium/work  XDG_CONFIG_HOME=/usr/ports/www/chromium/work  HOME=/usr/ports/www/chromium/work SHELL=/bin/sh CONFIG_SHELL=/bin/sh /usr/local/bin/python2.7  build/gyp_chromium --depth . -Ichromiumcontent/chromiumcontent.gypi chromiumcontent/chromiumcontent.gyp
sudo /usr/bin/env CC="cc"  CXX="c++"  GYP_GENERATORS=ninja  GYP_GENERATOR_FLAGS="output_dir=out_ffmpeg" GYP_DEFINES="clang_use_chrome_plugins=0   linux_breakpad=0  linux_use_heapchecker=0  linux_strip_binary=1  use_aura=1  mac_mas_build=1 test_isolation_mode=noop  disable_nacl=1  enable_extensions=1  enable_one_click_signin=1  enable_openmax=1  enable_webrtc=1  werror=  no_gc_sections=1  OS=freebsd  os_ver=1100122  prefix_dir=/usr/local  python_ver=2.7  use_allocator=none  use_cups=1  linux_link_gsettings=1  linux_link_libpci=1  linux_link_libspeechd=1  libspeechd_h_prefix=speech-dispatcher/  usb_ids_path=/usr/local/share/usbids/usb.ids  want_separate_host_toolset=0  use_system_bzip2=1  use_system_flac=1  use_system_harfbuzz=1  use_system_icu=1  use_system_jsoncpp=1  use_system_libevent=1  use_system_libexif=1  use_system_libjpeg=1  use_system_libpng=1  use_system_libusb=1  use_system_libwebp=1  use_system_libxml=1  use_system_libxslt=1  use_system_nspr=1  use_system_protobuf=0  use_system_re2=1  use_system_snappy=1  use_system_speex=1  use_system_xdg_utils=1  use_system_yasm=1  v8_use_external_startup_data=1  google_api_key=AIzaSyBsp9n41JLW8jCokwn7vhoaMejDFRd1mp8  google_default_client_id=996322985003.apps.googleusercontent.com  google_default_client_secret=IR1za9-1VK0zZ0f_O8MVFicn ffmpeg_branding=Chromium proprietary_codecs=1 use_gconf=1 use_pulseaudio=0 clang=1" ac_cv_path_PERL=/usr/local/bin/perl ac_cv_path_PERL_PATH=/usr/local/bin/perl PKG_CONFIG=pkgconf PYTHON="/usr/local/bin/python2.7" AR=/usr/bin/ar CFLAGS="-O2 -pipe  -isystem/usr/local/include -I/usr/local/include/atk-1.0 -Wno-unknown-warning-option -D_LIBCPP_TRIVIAL_PAIR_COPY_CTOR=1 -fstack-protector -fno-strict-aliasing"  CPPFLAGS=""  CXXFLAGS="-O2 -pipe -isystem/usr/local/include -I/usr/local/include/atk-1.0 -Wno-unknown-warning-option -D_LIBCPP_TRIVIAL_PAIR_COPY_CTOR=1 -fstack-protector -fno-strict-aliasing "  LDFLAGS=" -fstack-protector" XDG_DATA_HOME=/usr/ports/www/chromium/work  XDG_CONFIG_HOME=/usr/ports/www/chromium/work  HOME=/usr/ports/www/chromium/work SHELL=/bin/sh CONFIG_SHELL=/bin/sh /usr/local/bin/python2.7  build/gyp_chromium --depth . -Ichromiumcontent/chromiumcontent.gypi chromiumcontent/chromiumcontent.gyp
sudo ninja -C out/Release chromiumcontent_all
sudo ninja -C out_component/Release chromiumcontent_all
sudo ninja -C out_ffmpeg/Release ffmpeg
cd out/Release
sudo find . -name "lib*.a" -exec cp {} . \;
cd ../../out_component/Release
sudo find . -name "lib*.a" -exec cp {} . \;
cd $BUILDROOT/libchromiumcontent/
#get icudtl.dat from vscode linux download and copy it to build root folder
sudo cp ../icudtl.dat src/out/Release
sudo cp ../icudtl.dat src/out_component/Release
./script/create-dist
cd $BUILDROOT
#Building ELECTRON ...
echo "Building ELECTRON ..."
git clone https://github.com/electron/electron.git
cd electron/
git checkout v1.3.7
patch  -p1 < ../electronv1.diff
set +e
#this will fail when it tries to download libchromiumcontent library
script/bootstrap.py -v --clang_dir=/usr
set -e
patch  -p1  -d vendor/native_mate/  < ../electron_vendor_native_matev1.diff
patch  -p1  -d vendor/brightray/  < ../electron_vendor_brightrayv1.diff
patch  -p1  -d vendor/brightray/vendor/libchromiumcontent/  < ../electron_vendor_libchromiumcontentv1.diff
unzip ../libchromiumcontent/libchromiumcontent.zip -d vendor/brightray/vendor/download/libchromiumcontent/
unzip ../libchromiumcontent/libchromiumcontent-static.zip -d vendor/brightray/vendor/download/libchromiumcontent/
script/bootstrap.py -v --clang_dir=/usr
script/build.py
script/create-dist.py
cd $BUILDROOT
#Building VSCODE
echo "Building VSCODE"
git clone https://github.com/microsoft/vscode
cd vscode/
#v1.7.0
git checkout translation/20161014.01
patch -p1  < ../vscodev1.diff
scripts/npm.sh install --arch=x64
patch -p1  < ../vscode.pty.cc.diff
gmake -C node_modules/pty.js/build/
./node_modules/.bin/gulp compile
# If the above command fails in monaco, run,
#./node_modules/.bin/gulp watch
#./node_modules/.bin/gulp compile
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$BUILDROOT/electron/dist/ 
../electron/dist/electron .
