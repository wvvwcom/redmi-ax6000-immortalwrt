这里是红米ax6000-stock固件，基于immortalwrt-24.10，可修改代码增加自己需要的插件，直接fork即可云编译，毫无保留。
  
地址为192.168.10.1 需要修改的自行在diy-part2.sh文件第二十行里修改
执行Action，在SSH connection to Actions连接选项输入true,run workflow
等待出现SSH链接，并点击打开新页面
进入ssh连接页面后ctrl+c
输入 cd openwrt && make menuconfig 进入图形选择界面，选择好所需插件后保存退出。LuCI ---> Applications 选择所需的插件

退出后输入ctrl+D
ACTION会自动开始后面的操作

执行顺序：
1、checkout branch
2、copy feeds.conf.default, if exist
3、run diy_part1.sh
4、update feeds
5、install feeds
6、copy .config, if exist
7、run diy_part2.sh
8、ssh login in, if enable
9、make defconfig && make download && make
10、upload
