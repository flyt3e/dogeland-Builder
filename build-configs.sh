# 项目根目录（同时存在 app,components,build,toolkit文件夹的一个目录）
PROJ_ROOT=$(pwd)
# 编译输出
PROJ_OUT=$PROJ_ROOT/out
# Components的文件夹
PROJ_SRC=$PROJ_ROOT/components
# 保存旧PATH来清理编译环境
OLDPATH=$PATH
# 编译时使用的NDK版本
NDK_VER=r23b
# NDK位置（会自动下载，如果不是特殊情况无需修改）
NDK=$PROJ_SRC/android-ndk-$NDK_VER
# 最低支持的Android API等级
API=23
# 目标编译架构（可设置多个）
ALL_ARCH="aarch64 arm x86_64"
# 启用components各部分调试
#APP_DEBUG=1