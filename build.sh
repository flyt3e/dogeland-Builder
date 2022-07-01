. scripts/build-configs.sh
if [ ! -d $BUILDER_OUT ]; then
mkdir -p $BUILDER_OUT
fi
if [ ! -d $BUILDER_SRC ]; then
mkdir -p $BUILDER_SRC
fi
for pkg_sh in pkgs/*
 do
    echo "==> Loading $pkg_sh"
    . $pkg_sh
    echo "==> Starting Builder"
    . scripts/loop-build.sh
    unset PKG
    unset PKG_URL
    cd $BUILDER_ROOT
    . scripts/clean-env.sh
done
