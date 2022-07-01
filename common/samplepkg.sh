# 软件包样本
PKG=samplepkg #名称，不重复即可
PKG_URL="Only Support tar.gz URL!" #可以不设置，设就是tar.gz链接
build() {
# 如何编译？
    # 进入源码目录
    cd $PKG_SRC
    # build cmds...
    cp xxx $BUILDER_OUT/xxx # 输出到保存目录
}