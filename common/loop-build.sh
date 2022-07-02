#!/bin/sh

set -e

##### prepare sources #####
#cd $PROJ_SRC
# 软件包配置中是否给到资源URL
#if [ $PKG_URL ];then
#	echo "Downloading $PKG sources"
#	# 检查代码包是否存在
#    if [ -e $PKG_FILE ]; then
#     echo 'skipping download'
#     # 存在忽略下载，并检查是否解压
#     if [ -d $PKG_SRC ]; then
#      # 下载并且已解压，跳过此步骤
#      echo 'skipping decompress'
#     else
#      # 下载但未解压，立即解压
#      tar xzf $PKG_FILE
#      rm $PKG_FILE
#     fi
#    else
#      # 完全不存在的时候，下载并解压
#      curl -#LOC - $PKG_URL
#      tar xzf $PKG_FILE
#      rm $PKG_FILE
#   fi
#else
#    # 这是一个不需要源码的包
#	echo "ignoring Download"
#fi
cd $PKG_SRC
##### loop build #####

# 循环多架构编译
for arch in $ALL_ARCH; do
    # 创建导出目录
    if [ ! -d $PROJ_OUT/bin/$arch ]; then
      mkdir -p $PROJ_OUT/bin/$arch
    fi
    if [ ! -d $PROJ_OUT/lib/$arch ]; then
      mkdir -p $PROJ_OUT/lib/$arch
    fi
    #设置工具链
    . $PROJ_ROOT/build/common/env-utils.sh setenv
    echo "===== $PKG build for $arch platform start ====="
    # 调用包配置中编译命令
    cd $PKG_SRC
    build
    echo "===== $PKG build for $arch platform done ====="
    # 清除环境，等待下一编译任务
    . $PROJ_ROOT/build/common/env-utils.sh unsetenv
done
