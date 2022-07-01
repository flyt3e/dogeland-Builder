PKG="proot"
PKG_URL="https://github.com/termux/proot/archive/refs/heads/master.tar.gz"
PKG_FILE="master.tar.gz"
PKG_SRC="$BUILDER_SRC/proot-master/"
build(){
    if [ -d talloc-2.3.3/ ]; then
      echo "skipping download libtalloc"
    else
     echo "Downloading libtalloc"
     curl -#LOC - https://www.samba.org/ftp/talloc/talloc-2.3.3.tar.gz
     tar xf talloc-2.3.3.tar.gz
    fi
    cd talloc-2.3.3

    tee cross-answers.txt << EOF > /dev/null
Checking uname sysname type: "Linux"
Checking uname machine type: "dontcare"
Checking uname release type: "dontcare"
Checking uname version type: "dontcare"
Checking simple C program: OK
building library support: OK
Checking for large file support: OK
Checking for -D_FILE_OFFSET_BITS=64: OK
Checking for WORDS_BIGENDIAN: OK
Checking for C99 vsnprintf: OK
Checking for HAVE_SECURE_MKSTEMP: OK
rpath library support: OK
-Wl,--version-script support: FAIL
Checking correct behavior of strtoll: OK
Checking correct behavior of strptime: OK
Checking for HAVE_IFACE_GETIFADDRS: OK
Checking for HAVE_IFACE_IFCONF: OK
Checking for HAVE_IFACE_IFREQ: OK
Checking getconf LFS_CFLAGS: OK
Checking for large file support without additional flags: OK
Checking for working strptime: OK
Checking for HAVE_SHARED_MMAP: OK
Checking for HAVE_MREMAP: OK
Checking for HAVE_INCOHERENT_MMAP: OK
Checking getconf large file support flags work: OK
EOF

    ./configure --prefix="./" \
                --cross-compile \
                --cross-answers=cross-answers.txt  \
                --disable-python \
                --disable-rpath
    
    make clean
    make install
    
    # libtalloc doesn't build static libraries automatically yet
    cd ./bin/default
    $AR rcu libtalloc.a talloc*.o
    install -Dm644 libtalloc.a $PKG_SRC/
    cd $PKG_SRC/talloc-2.3.3
    make clean
    
    cd $PKG_SRC/src
    make clean
    make V=1 CFLAGS="$CFLAGS -I$PKG_SRC/talloc-2.3.3/include" LDFLAGS="$LDFLAGS $PKG_SRC/libtalloc.a"

    $STRIP ./proot
    $STRIP ./loader/loader
    if [ -e ./loader/loader-m32 ]; then
     $STRIP ./loader/loader-m32
    fi
    
    install -Dm644 ./proot $BUILDER_OUT/proot_$arch
    install -Dm644 ./loader/loader $BUILDER_OUT/libloader.so_$arch
    if [ -e ./loader/loader-m32 ]; then
     install -Dm644 ./loader/loader-m32 $BUILDER_OUT/libloader32.so_$arch
    fi
    make clean
    rm $PKG_SRC/libtalloc.a
}