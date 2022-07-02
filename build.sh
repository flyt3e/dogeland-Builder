# 加载主要编译配置
. build/build-configs.sh
# 创建输出目录
if [ ! -d $PROJ_OUT ]; then
mkdir -p $PROJ_OUT/bin
fi
# 循环加载目标编译配置
for pkg_sh in build/steps/*
 do
    echo "==> 正在加载 $pkg_sh"
    . $pkg_sh
    echo "==> 正在编译"
    . build/common/loop-build.sh
    unset PKG
    cd $PROJ_ROOT
    . build/common/env-utils.sh unsetenv
done
