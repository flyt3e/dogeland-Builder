PKG="app"
PKG_URL="https://github.com/flyt3e/tainer_app/archive/refs/heads/master.tar.gz"
PKG_FILE="master.tar.gz"
PKG_SRC="$BUILDER_SRC/tainer_app-master/"
build(){
if [ -e $BUILDER_OUT/app-release.apk ]; then
 echo 'skipping build'
else
 # proot
 cp $BUILDER_OUT/proot* app/src/main/assets/app_xbin/preload/bin/
 # libtainer
 cp $BUILDER_OUT/libtainer* app/src/main/assets/app_xbin/preload/bin/
 # proot loader
 for arch in aarch64 arm x86_64; do
  cp $BUILDER_OUT/libloader.so_$arch app/src/main/assets/app_xbin/preload/lib/$arch/libloader.so
  # for 64bit
  if [ -e $BUILDER_OUT/libloader32.so_$arch ]; then
   cp $BUILDER_OUT/libloader32.so_$arch app/src/main/assets/app_xbin/preload/lib/$arch/libloader32.so
  fi
 done
 chmod +x ./gradlew
 ./gradlew build
 install -Dm644 app/build/outputs/apk/release/app-release.apk $BUILDER_OUT/app-release.apk
fi
}