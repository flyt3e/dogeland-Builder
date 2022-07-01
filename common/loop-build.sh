#!/bin/sh

set -e

##### prepare sources #####
#PKG_SRC="$BUILDER_SRC/$PKG/"
#mkdir -p $PKG_SRC
cd $BUILDER_SRC
# 软件包配置中是否给到资源URL
if [ $PKG_URL ];then
	echo "Downloading $PKG sources"
	# 检查代码包是否存在
    if [ -e $PKG_FILE ]; then
     echo 'skipping download'
     # 存在忽略下载，并检查是否解压
     if [ -d $PKG_SRC ]; then
      # 下载并且已解压，跳过此步骤
      echo 'skipping decompress'
     else
      # 下载但未解压，立即解压
      tar xzf $PKG_FILE
      rm $PKG_FILE
     fi
    else
      # 完全不存在的时候，下载并解压
      curl -#LOC - $PKG_URL
      tar xzf $PKG_FILE
      rm $PKG_FILE
   fi
else
    # 这是一个不需要源码的包
	echo "ignoring Download"
fi
cd $PKG_SRC
##### loop build #####

for arch in $ALL_ARCH; do
    . $BUILDER_ROOT/scripts/set-env.sh
    echo "===== $PKG build for $arch platform start ====="
    build
    echo "===== $PKG build for $arch platform done ====="
    . $BUILDER_ROOT/scripts/clean-env.sh
done
