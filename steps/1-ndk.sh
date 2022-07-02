PKG="ndk"
build(){
if [ -d $NDK ]; then
      echo 'skipping download'
else
 cd $PROJ_SRC
 echo "Downloading Android NDK ${NDK_VER}"
 case "$(uname)" in
 Linux)
     HOST_TAG='linux'
     ;;
 Darwin)
     HOST_TAG='darwin'
     ;;
 *)
     HOST_TAG='unknown'
     ;;
 esac
 # if you have already downloaded Android NDK
 # please edit NDK at build/build-configs.sh
 curl -#LOC - "https://dl.google.com/android/repository/android-ndk-${NDK_VER}-${HOST_TAG}.zip"
 unzip -oq "android-ndk-${NDK_VER}-${HOST_TAG}.zip"
fi
}