#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Uncomment a feed source
# sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
# sed -i '1i src-git danshui https://github.com/281677160/openwrt-package.git;immortalwrt' feeds.conf.default
# sed -i '2i src-git dstheme https://github.com/281677160/openwrt-package.git;Theme2' feeds.conf.default
# echo 'src-git alist https://github.com/sbwml/luci-app-alist' >>feeds.conf.default
# echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
# passwall
sed -i '1i src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main' feeds.conf.default
sed -i '2i src-git passwall_luci https://github.com/xiaorouji/openwrt-passwall.git;main' feeds.conf.default
sed -i '3i src-git passwall2_luci https://github.com/xiaorouji/openwrt-passwall2.git;main' feeds.conf.default
sed -i '4i src-git vnt https://github.com/lmq8267/luci-app-vnt.git;main' feeds.conf.default
# helloworld
# sed -i '1i src-git helloworld https://github.com/fw876/helloworld.git;master' feeds.conf.default

# Add a feed source
# echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
# echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
# echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >>feeds.conf.default   
# echo 'src-git small https://github.com/kenzok8/small' >>feeds.conf.default
# git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
# git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# add alist
# rm -rf feeds/packages/net/alist
# rm -rf feeds/luci/applications/luci-app-alist
# git clone https://github.com/sbwml/luci-app-alist feeds/alist
# mv ./feeds/alist/alist ./feeds/packages/net
# mv ./feeds/alist/luci-app-alist feeds/luci/applications/
# rm -rf feeds/alist
