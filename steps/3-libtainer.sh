PKG="libtainer"
PKG_URL="https://github.com/flyt3e/tainer_libtainer/archive/refs/heads/v0.0.x.tar.gz"
PKG_FILE="v0.0.x.tar.gz"
PKG_SRC="$BUILDER_SRC/tainer_libtainer-0.0.x/"
build() {
    chmod +x make.sh
    CC=$CC ./make.sh all
    # Install to outputs
    install ./libtainer $BUILDER_OUT/libtainer_$arch
    # clean up
    ./make.sh clean
}