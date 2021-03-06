#!/bin/bash
. $(dirname $0)/environment.sh
pushd $KIVYIOSROOT/src/SDL/Xcode-iOS/SDL
xcodebuild -project SDL.xcodeproj -target libSDL -configuration Release -sdk iphoneos$SDKVER
popd

cp src/SDL/Xcode-iOS/SDL/build/Release-iphoneos/libSDL.a $BUILDROOT/lib
cp -a src/SDL/include $BUILDROOT/include/SDL 

cat>$BUILDROOT/pkgconfig/sdl.pc<<EOF
# sdl pkg-config source file

prefix=$BUILDROOT
exec_prefix=\${prefix}
libdir=\${exec_prefix}/lib
includedir=\${prefix}/include

Name: sdl
Description: Simple DirectMedia Layer is a cross-platform multimedia library designed to provide low level access to audio, keyboard, mouse, joystick, 3D hardware via OpenGL, and 2D video framebuffer.
Version: 1.2.15
Requires:
Conflicts:
Libs: -L\${libdir}  -lSDLmain -lSDL   -Wl,-framework,Cocoa
Libs.private: \${libdir}/libSDLmain.a \${libdir}/libSDL.a  -Wl,-framework,OpenGL  -Wl,-framework,Cocoa -Wl,-framework,ApplicationServices -Wl,-framework,Carbon -Wl,-framework,AudioToolbox -Wl,-framework,AudioUnit -Wl,-framework,IOKit
Cflags: -I\${includedir}/SDL -D_GNU_SOURCE=1 -D_THREAD_SAFE
EOF

