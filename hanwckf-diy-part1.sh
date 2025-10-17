#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# mkdir -p package/wvvwcom
# svn co https://github.com/NueXini/NueXini_Packages/trunk/alist package/wvvwcom/alist
# svn co https://github.com/NueXini/NueXini_Packages/trunk/luci-app-alist package/wvvwcom/luci-app-alist
# svn co https://github.com/NueXini/NueXini_Packages/trunk/luci-app-vlmcsd package/wvvwcom/luci-app-vlmcsd
# svn co https://github.com/kiddin9/openwrt-packages/trunk/frp package/wvvwcom/frp
# svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-frpc package/wvvwcom/luci-app-frpc


### 添加第三方订阅源（这边建议编译后去更改成中科大的源）
# sed -i '$a src-git-full small https://github.com/kenzok8/small-package' feeds.conf.default
# git clone https://github.com/CHN-beta/rkp-ipid package/rkp-ipid

### 直接添加helloworld源会报错，暂时屏蔽 
# sed -i '1i\src-git helloworld https://github.com/fw876/helloworld.git;main' feeds.conf.default
# sed -i '$a src-git nuexini https://github.com/NueXini/NueXini_Packages' feeds.conf.default
# sed -i '$a src-git kiddin9 https://github.com/kiddin9/openwrt-packages.git' feeds.conf.default



