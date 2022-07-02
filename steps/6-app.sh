PKG="app"
PKG_SRC="$PROJ_ROOT/app"
build(){
if [ -e $PROJ_OUT/app-release.apk ]; then
 echo 'skipping build'
else
 # libtainer
 #cp $PROJ_OUT/libtainer* app/src/main/assets/Toolkit/Preload/bin/
 cp $PROJ_ROOT/toolkit/toolkit.sh $PROJ_ROOT/App/app/src/main/assets/Toolkit/
 for arch in aarch64 arm x86_64; do
  if [[ "$arch" = "aarch64" ]];then
   unset arch
   export arch=aa64
  fi
  if [[ "$arch" = "x86_64" ]];then
   unset arch
   export arch=x64
  fi
  cp $PROJ_OUT/bin/$arch/* $PROJ_ROOT/App/app/src/main/assets/Toolkit/Preload/bin/$arch/
  cp $PROJ_OUT/lib/$arch/libloader.so $PROJ_ROOT/App/app/src/main/assets/Toolkit/Preload/lib/$arch/libloader.so
  # for 64bit
  if [ -e $PROJ_OUT/lib/$arch/libloader32.so ]; then
   cp $PROJ_OUT/lib/$arch/libloader32.so $PROJ_ROOT/App/app/src/main/assets/Toolkit/Preload/lib/$arch/libloader32.so
  fi
 done
 chmod +x ./gradlew
 ./gradlew build
 install -Dm644 app/build/outputs/apk/release/app-release.apk $PROJ_OUT/app-release.apk
fi
}