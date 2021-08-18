# upstart_test

## 概要

upstartを使ったプロセスの始動と、プロセスの永続化のテストを行うために作られたリポジトリである。

このリポジトリではsleepコマンドの永続化をテストをしている。

## 検証環境

- M1 Mac
- Docker version 20.10.7, build f0df350

## 起動方法

```
$ docker build -t upstart_test .
$ docker run --rm -d --name upstart_test upstart_test 
$ docker exec -it upstart_test bash
```

## 検証方法

### sleepが起動しているか？

以下のような状態になっていればsleepが起動されたことがわかる

```
# ps uax
root         1  0.5  0.6 255540 14128 ?        Ssl  09:30   0:00 /usr/bin/qemu-x86_64 /sbin/init
root        68  0.0  0.3 226376  6880 ?        Ssl  09:30   0:00 /usr/bin/qemu-x86_64 /bin/sleep 100000000
root       116  0.2  0.7 284640 15484 ?        Ssl  09:30   0:00 /usr/bin/qemu-x86_64 /usr/sbin/sshd -D
root       184  3.5  0.5 240848 11896 pts/0    Ssl  09:30   0:00 /usr/bin/qemu-x86_64 /bin/bash
root       215  0.0  0.4 237852  8308 ?        Rl+  09:04   0:00 /bin/ps uax
```

### sleepを強制終了する

sleepのプロセスIDが変わっていればOK

```
# pkill -f sleep
# ps uax
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.6 255540 14132 ?        Ssl  09:30   0:00 /usr/bin/qemu-x86_64 /sbin/init
root       116  0.0  0.7 284640 15484 ?        Ssl  09:30   0:00 /usr/bin/qemu-x86_64 /usr/sbin/sshd -D
root       184  0.0  0.6 240848 13976 pts/0    Ssl  09:30   0:00 /usr/bin/qemu-x86_64 /bin/bash
root       221  0.5  0.3 226376  6880 ?        Ssl  09:32   0:00 /usr/bin/qemu-x86_64 /bin/sleep 100000000
root       228  0.0  0.4 237852  8308 ?        Rl+  09:04   0:00 /bin/ps uax
```