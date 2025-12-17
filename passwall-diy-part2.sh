#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.

function merge_package() {
    # 参数1是分支名,参数2是库地址,参数3是所有文件下载到指定路径。
    # 同一个仓库下载多个文件夹直接在后面跟文件名或路径，空格分开。
    if [[ $# -lt 3 ]]; then
        echo "Syntax error: [$#] [$*]" >&2
        return 1
    fi
    trap 'rm -rf "$tmpdir"' EXIT
    branch="$1" curl="$2" target_dir="$3" && shift 3
    rootdir="$PWD"
    localdir="$target_dir"
    [ -d "$localdir" ] || mkdir -p "$localdir"
    tmpdir="$(mktemp -d)" || exit 1
    git clone -b "$branch" --depth 1 --filter=blob:none --sparse "$curl" "$tmpdir"
    cd "$tmpdir"
    git sparse-checkout init --cone
    git sparse-checkout set "$@"
    # 使用循环逐个移动文件夹
    for folder in "$@"; do
        rm -rf  "$rootdir/$localdir/${folder##*/}"
        mv -f   "$folder" "$rootdir/$localdir"
    done
    cd "$rootdir"
}

#
# 解决冲突（适用于kenzok8插件源码）
# rm -rf feeds/luci/applications/luci-app-mosdns
# rm -rf feeds/packages/net/{alist,adguardhome,mosdns,xray*,v2ray*,v2ray*,sing*,smartdns}
# rm -rf feeds/packages/utils/v2dat
# rm -rf feeds/packages/lang/golang
# git clone https://github.com/kenzok8/golang feeds/packages/lang/golang

# 设置主路由静态IP
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.6.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# 设置密码为空
# sed -i '/CYXluq4wUazHjmCDBCqXF/d' package/lean/default-settings/files/zzz-default-settings

# 替换包版本，xray编译要求高版本golang
merge_package master https://github.com/coolsnowwolf/packages         feeds/packages/lang       lang/golang
merge_package main https://github.com/wvvwcom/openwrt-package-frpc    feeds/packages/net        net/frp
merge_package main https://github.com/wvvwcom/openwrt-package-frpc    feeds/luci/applications   applications/luci-app-frpc
merge_package master https://github.com/immortalwrt/packages          feeds/packages/net        net/zerotier
merge_package master https://github.com/immortalwrt/luci              feeds/luci/applications   applications/luci-app-zerotier

# 非替换的包，需要直接拷贝到package目录，不然无法安装
merge_package main https://github.com/Lienol/openwrt-package          package/feeds/luci   luci-app-timecontrol
merge_package main https://github.com/Lienol/openwrt-package          package/feeds/luci   luci-app-socat
# EasyTier
merge_package main https://github.com/EasyTier/luci-app-easytier.git  package/feeds/packages    easytier
merge_package main https://github.com/EasyTier/luci-app-easytier.git  package/feeds/luci        luci-app-easytier
# Lucky
merge_package main https://github.com/gdy666/luci-app-lucky           package/feeds/packages    lucky
merge_package main https://github.com/gdy666/luci-app-lucky           package/feeds/luci        luci-app-lucky

# ilxp/luci-app-ikoolproxy
rm -rf package/feeds/luci/luci-app-ikoolproxy
git clone https://github.com/ilxp/luci-app-ikoolproxy.git package/feeds/luci/luci-app-ikoolproxy


# 替换默认主题为luci-theme-argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-light/Makefile

# 安装新主题 luci-theme-bootstrap-mod
# git clone https://github.com/leshanydy2022/luci-theme-bootstrap-mod.git package/lean/luci-theme-bootstrap-mod
# sed -i 's/luci-theme-bootstrap/luci-theme-bootstrap-mod/g' feeds/luci/collections/luci/Makefile

# 安装luci-app-smartdns和luci-app-adguardhome
# rm -rf feeds/luci/applications/luci-app-smartdns
# rm -rf feeds/luci/applications/luci-app-adguardhome
# git clone https://github.com/leshanydy2022/luci-app-smartdns.git feeds/luci/applications/luci-app-smartdns
# git clone https://github.com/leshanydy2022/luci-app-adguardhome.git package/lean/luci-app-adguardhome

# 为adguardhome插件更换最新的版本
# rm -rf feeds/packages/net/adguardhome
# git clone https://github.com/leshanydy2022/adguardhome.git feeds/packages/net/adguardhome

# 安装uugamebooster
# rm -rf feeds/luci/applications/luci-app-uugamebooster
# git clone https://github.com/datouha/luci-app-uugamebooster.git package/lean/luci-app-uugamebooster
# rm -rf feeds/packages/net/uugamebooster
# git clone https://github.com/datouha/uugamebooster.git feeds/packages/net/uugamebooster



# ---------------------------------------------------------------
## OpenClash
# git clone -b v0.46.086 --depth=1 https://github.com/vernesong/openclash.git OpenClash
# rm -rf feeds/luci/applications/luci-app-openclash
# mv OpenClash/luci-app-openclash feeds/luci/applications/luci-app-openclash
# ---------------------------------------------------------------

# ##------------- meta core ---------------------------------
# wget https://github.com/MetaCubeX/mihomo/releases/download/v1.19.9/mihomo-linux-arm64-v1.19.9.gz
# gzip -d mihomo-linux-arm64-v1.19.9.gz
# chmod +x mihomo-linux-arm64-v1.19.9 >/dev/null 2>&1
# mkdir -p feeds/luci/applications/luci-app-openclash/root/etc/openclash/core
# mv mihomo-linux-arm64-v1.19.9 feeds/luci/applications/luci-app-openclash/root/etc/openclash/core/clash_meta >/dev/null 2>&1
# ##---------------------------------------------------------

# ##-------------- GeoIP 数据库 -----------------------------
# curl -sL -m 30 --retry 2 https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat -o /tmp/GeoIP.dat
# mv /tmp/GeoIP.dat feeds/luci/applications/luci-app-openclash/root/etc/openclash/GeoIP.dat >/dev/null 2>&1
# ##---------------------------------------------------------

# ##-------------- GeoSite 数据库 ---------------------------
# curl -sL -m 30 --retry 2 https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat -o /tmp/GeoSite.dat
# mv -f /tmp/GeoSite.dat feeds/luci/applications/luci-app-openclash/root/etc/openclash/GeoSite.dat >/dev/null 2>&1

# 为smartDNS插件更换最新的版本
# rm -rf feeds/packages/net/smartdns
# git clone https://github.com/leshanydy2022/smartdns.git feeds/packages/net/smartdns

# Modify hostname
# sed -i 's/ImmortalWrt/ImmortalWrt-YDY/g' package/base-files/files/bin/config_generate

# Modify filename, add date prefix
# sed -i 's/IMG_PREFIX:=/IMG_PREFIX:=$(shell date +"%Y%m%d")-/1' include/image.mk

# Modify ppp-down, add sleep 3
# sed -i '$a\\\nsleep 3' package/network/services/ppp/files/lib/netifd/ppp-down
