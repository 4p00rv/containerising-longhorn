# So far

iscsi is installed. The kernel module error are fixed using `--cap-add` in docker

Currently when running iscsid in forgroud with debug on, it fails and exits with error code 255

Output
```
$ /sbin/iscsid -f -d 7 -c /etc/iscsi/iscsid.conf
iscsid: sysfs_init: sysfs_path='/sys'
iscsid: InitiatorName=iqn.2004-10.com.ubuntu:01:87427e7ddc32
iscsid: InitiatorName=iqn.2004-10.com.ubuntu:01:87427e7ddc32
iscsid: InitiatorAlias=3e3a69106980
iscsid: Max file limits 1048576 1048576
iscsid: found 10.42.0.19,3260
iscsid: Looking for config file /etc/iscsi/send_targets/10.42.0.19,3260
iscsid: Looking for config file /etc/iscsi/send_targets/10.42.0.19,3260 config st_config.
iscsid: st_start 10.42.0.19:3260 0
iscsid: poll result 1
iscsid: Matched transport tcp
iscsid: sysfs_attr_get_value: open '/class/iscsi_transport/tcp'/'handle'
iscsid: sysfs_attr_get_value: open '/class/iscsi_transport/tcp'/'caps'
iscsid: Allocted session 0x5567349067f0
iscsid: no authentication configured...
iscsid: resolved 10.42.0.19 to 10.42.0.19
iscsid: setting iface default, dev , set ip , hw , transport tcp.
iscsid: set TCP recv window size to 524288, actually got 425984
iscsid: set TCP send window size to 524288, actually got 425984
iscsid: connecting to 10.42.0.19:3260
iscsid: Setting login timer 0x55673490e758 timeout 15
iscsid: connected local port 45226 to 10.42.0.19:3260
iscsid: sendmsg: bug? ctrl_fd 4
```

Source code for open-iscsi is here: https://github.com/open-iscsi/open-iscsi

One option is to run k3s in a vm and compare to container. Debug logs can help with digging it deeper.

