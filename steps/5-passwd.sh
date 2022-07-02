PKG="passwd"
PKG_SRC="$PROJ_SRC/tainer-passwd"
build(){
 cmake .
 make clean
 make
 install -Dm644 ./pwlogin $PROJ_OUT/bin/$arch/pwlogin
 install -Dm644 ./passwd $PROJ_OUT/bin/$arch/passwd
 install -Dm644 ./testauth $PROJ_OUT/bin/$arch/testauth
 install -Dm644 ./libtainer-auth.so $PROJ_OUT/lib/$arch/libtainer-auth.so
 make clean
}