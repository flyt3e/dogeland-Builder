PKG="ndk_patch"
build(){
if [ -e $NDK/toolchains/llvm/prebuilt/linux-x86_64/sysroot/.patch ]; then
 echo 'skipping patch'
else
 cp $PROJ_ROOT/build/ndk-patches/*.patch $NDK/toolchains/llvm/prebuilt/linux-x86_64/sysroot/
 cp $PROJ_ROOT/build/ndk-patches/*.h $NDK/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include/
 cd $NDK/toolchains/llvm/prebuilt/linux-x86_64/sysroot/
 # add patch
 for patchfile in ./*.patch
 do
    echo "==> Applying: $patchfile"
    patch -p1 < $patchfile
    rm $patchfile
 done
 touch .patch
fi
}