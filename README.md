# Shell
Summary of personal experience: Shell scripts used in work.

## buildroot (开机脚本)
1. 在 /etc/init.d/rcS文件 增加/usr/etc/rc.local

2. 创建rc.local文件 touch /usr/etc/rc.local 并在rc.local中添加调用脚本

   ```c
   rc.local脚本内容如下：
   #!/bin/bash
   cd /mnt/
   ./test_script &
   ```

