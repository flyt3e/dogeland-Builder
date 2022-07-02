PKG="proot"
PKG_SRC="$PROJ_SRC/proot/"
build(){
    if [ -d talloc-2.3.3/ ]; then
      echo "skipping download libtalloc"
    else
     echo "NEED libtalloc!"
     exit 255
    fi
    # 编译libtalloc
    chmod -R +x ./
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
    chmod +x  ./configure
    ./configure --prefix="./" \
                --cross-compile \
                --cross-answers=cross-answers.txt  \
                --disable-python \
                --disable-rpath
    
    make clean
    make install
    # 导出静态库
    # libtalloc doesn't build static libraries automatically yet
    cd ./bin/default
    $AR rcu libtalloc.a talloc*.o
    install -Dm644 libtalloc.a $PKG_SRC/
    
    # 清理libtalloc
    cd $PKG_SRC/talloc-2.3.3
    make clean
    # 编译proot
    cd $PKG_SRC/src
    make clean
    make V=1 CFLAGS="$CFLAGS -I$PKG_SRC/talloc-2.3.3/include" LDFLAGS="$LDFLAGS $PKG_SRC/libtalloc.a"

    $STRIP ./proot
    $STRIP ./loader/loader
    if [ -e ./loader/loader-m32 ]; then
     $STRIP ./loader/loader-m32
    fi
    # 导出
    install -Dm644 ./proot $PROJ_OUT/bin/$arch/proot
    install -Dm644 ./loader/loader $PROJ_OUT/bin/$arch/libloader.so
    if [ -e ./loader/loader-m32 ]; then
     install -Dm644 ./loader/loader-m32 $PROJ_OUT/bin/$arch/libloader32.so
    fi
    # 清理
    make clean
    rm $PKG_SRC/libtalloc.a
}