# ZFS File System
### Install [ZFS on Linux](http://download.zfsonlinux.org/epel/zfs-release.el6.noarch.rpm)

### RedHat and Fedora distros

#### Install `ZFS` Packages

```bash
yum install kernel-devel zfs
```

### ZFS management

#### Get statistics of All

```bash
zfs-stat -A
```

#### List `ZFS` Tanks

```bash
zfs list | grep tank
```

#### Check if `ZFS` package is installed

```bash
rpm -aq | grep zfs
```

```bash
zfs version
```

```bash
zfs list
```

```bash
cat /proc/spl/kstat/zfs/arcstats
```

```bash
zfs get all
```

```bash
dmesg | grep -i zfs
```

#### Enable ZFS functions and obtain ZFS info

```bash
sudo systemctl enable zfs-import-scan.service
zpool get cachefile fix zfs-import-cache
```

#### ZFS service not starting run the below commands

```bash
zpool set cachefile=/etc/zfs/zpool.cache <pool>
systemctl restart zfs-import-cache.service
```

#### Make sure `ZFS` module is installed for the running Linux Kernel

```bash
modinfo zfs
```

#### Ensure the ZFS module is running

```bash
lsmod | grep zfs
```

## `ZFS` **Pool Related Commands**

#### Create a basic pool named `c0t0d0`

```bash
zpool create datapool c0t0d0
```

#### Force the creation of a pool

```bash
zpool create -f datapool c0t0d0
```

#### Create a pool with a different mount point than the default

```bash
zpool create -m /data datapool c0t0d0
```

#### Create RAID-Z vdev pool todo_ADD references

```bash
zpool create datapool raidz c3t0d0 c3t1d0 c3t2d0
```

#### Add RAID-Z vdev to pool datapool todo_ADD references

```bash
zpool add datapool raidz c4t0d0 c4t1d0 c4t2d0 
```

#### Create RAID-Z1 pool todo_ADD references

```bash
zpool create datapool raidz1 c0t0d0 c0t1d0 c0t2d0 c0t3d0 c0t4d0 c0t5d0
```

#### Create RAID-Z2 pool todo_ADD references

```bash
zpool create datapool raidz2 c0t0d0 c0t1d0 c0t2d0 c0t3d0 c0t4d0 c0t5d0
```

#### Mirror c0t0d0 to c0t5d0

```bash
zpool create datapool mirror c0t0d0 c0t5d0
```

#### Mirrors=Disk `c0t0d0` is mirrored with `c0t5d0` ; disk `c0t2d0` is mirrored with `c0t4d0`

```bash
zpool create datapool mirror c0t0d0 c0t5d0 mirror c0t2d0 c0t4d0
```

#### Add new mirrored vdev to datapool

```bash
zpool add datapool mirror c3t0d0 c3t1d0
```

#### Add spare device c1t3d0 to the datapool

```bash
zpool add datapool spare c1t3d0
```

#### Do a dry run on pool creation

```bash
zpool create -n geekpool c1t3d0
```

#### Show Pool Information status

```bash
zpool status -x
```

#### Show individual pool status in verbose mode

```bash
zpool status -v datapool
```

#### Show all the pools

```bash
zpool list
```

#### Show particular properties of all the pools (name, size)

```bash
zpool list -o name,size
```

#### Show all pools without headers and columns

```bash
zpool list -Ho name
```

### `ZFS` File-system/Volume related commands

#### Create file-system fs1 under datapool

```bash
zfs create datapool/fs1
```

#### Create 1 GB volume (Block device) in datapool

```bash
zfs create -V 1gb datapool/vol01
```

#### Destroy datapool and all datasets under it

```bash
zfs destroy -r datapool
```

#### Destroy file-system or volume (data) and all related snapshots

```bash
zfs destroy -fr datapool/data
```

#### Set ZFS file system properties

#### Set quota of 1 GB on filesystem fs1

```bash
zfs set quota=1G datapool/fs1
```

#### Set Reservation of 1 GB on filesystem `fs1`

```bash
zfs set reservation=1G datapool/fs1
```

#### Disable ZFS auto mounting and enable mounting through config file `/etc/vfstab`

```bash
zfs set mountpoint=legacy datapool/fs1
```

#### Share fs1 as NFS

```bash
zfs set sharenfs=on datapool/fs1
```

#### Enable compression on `fs1`

```bash
zfs set compression=on datapool/fs1
```

### `ZFS` File-system/Volume related commands

#### Create file-system `fs1` under datapool

```bash
zfs create datapool/fs1
```

#### Create 1 GB volume (Block device) in datapool

```bash
zfs create -V 1gb datapool/vol01
```

#### Destroy datapool and all datasets under it

```bash
zfs destroy -r datapool
```

#### Destroy file-system or volume (data) and all related snapshots

```bash
zfs destroy -fr datapool/data
```

#### List all ZFS file system

```bash
zfs list
```

#### List all properties of a ZFS file system

```bash
zfs get all datapool
```

### `ZFS` Mount/Umount Related Commands

#### Set the mount-point of file system fs1 to /data

```bash
zfs set mountpoint=/data datapool/fs1
```

#### Mount fs1 file system

```bash
zfs mount datapool/fs1
```

#### Mount with options todo_Add options explanation

```bash
mount -t zfs /dev/xvdf /media/atl
```

#### Unmount ZFS file system fs1

```bash
zfs umount datapool/fs1 
```

#### Mount all ZFS file systems

```bash
zfs mount -a

# Direct binary
/sbin/zfs mount -a
```

#### Mount all with arguments

```bash
zfs mount -O -a
```

#### Umount all ZFS file systems

```bash
zfs umount -a
```

### `ZFS` I/O performance

#### Display ZFS I/O Statistics every 2 seconds

```bash
zpool iostat 2
```

#### Display detailed ZFS I/O statistics every 2 seconds

```bash
zpool iostat -v 2
```

### `ZFS` maintenance commands

#### Run scrub on all file systems under data pool

```bash
zpool scrub datapool
```

#### Temporarily offline a disk (until next reboot)

```bash
zpool offline -t datapool c0t0d0
```

#### Online a disk to clear error count

```bash
zpool online
```

#### Clear error count without a need to the disk

```bash
zpool clear
```

### `ZFS` Import/Export Commands

#### List pools available for import

```bash
zpool import
```

#### Imports all pools found in the search directories

```bash
zpool import -a
```

#### Search for pools with block devices not located in `/dev/dsk`

```bash
zpool import -d
```

#### Search for a pool with block devices created in `/zfs`

```bash
zpool import -d /zfs datapool
```

#### Import a pool originally named oldpool under new name newpool

```bash
zpool import oldpool newpool
```

#### Import pool using `pool_ID`

```bash
zpool import 3987837483
```

#### Deport a ZFS pool named mypool

```bash
zpool export datapool
```

#### Force the unmount and deport of a ZFS pool

```bash
zpool export -f datapool
```

### `ZFS` Snapshot Commands

#### Create a snapshot named 12jan2014 of the fs1 filesystem

```bash
zfs snapshot datapool/fs1@12jan2014
```

#### List snapshots

```bash
zfs list -t snapshot
```

#### Roll back to Jan 10 2020 (recursively destroy intermediate snapshots)

```bash
zfs rollback -r datapool/fs1@10jan2020
```

#### Roll back: force unmount and remount

```bash
zfs rollback -rf datapool/fs1@10jan2020
```

#### Destroy snapshot created earlier

```bash
zfs destroy datapool/fs1@10jan2020
```

#### Take a backup of ZFS snapshot locally

```bash
zfs send datapool/fs1@oct2019 &gt /geekpool/fs1/oct2019.bak
```

#### Restore from the snapshot backup backup taken

```bash
zfs receive anotherpool/fs1 &lt /geekpool/fs1/oct2013.bak
```

#### Combine the `send` and `receive` operation

```bash
zfs send datapool/fs1@oct2019 | zfs receive anotherpool/fs1
```

#### Send the snapshot to a remote system `node02`

```bash
zfs send datapool/fs1@oct2019 | ssh node02 “zfs receive testpool/testfs”
```

### `ZFS` Clone Commands

#### Clone an existing snapshot

```bash
zfs clone datapool/fs1@10jan2014 /clones/fs1
```

#### Destroy clone

```bash
zfs destroy datapool/fs1@10jan2020
```

### ZFS References

1. [Solaris ZFS command line reference (Cheat sheet)](https://www.thegeekdiary.com/solaris-zfs-command-line-reference-cheat-sheet/)
1. [Solaris ZFS : How to replace a failed disk in rpool (x86)](https://www.thegeekdiary.com/solaris-zfs-how-to-replace-a-failed-disk-in-rpool-x86/)
1. [Solaris ZFS : How to Offline / Online / Detach / Replace device in a storage pool](https://www.thegeekdiary.com/solaris-zfs-how-to-offline-online-detach-replace-device-in-a-storage-pool/)
1. [How to Backup and Restore ZFS root pool in Solaris 10](https://www.thegeekdiary.com/how-to-backup-and-restore-zfs-root-pool-in-solaris-10/)
1. [Solaris ZFS : How to Create / Rename / Rollback / Destroy a ZFS Snapshot](https://www.thegeekdiary.com/solaris-zfs-how-to-create-rename-rollback-destroy-a-zfs-snapshot/)
1. [How to replace a disk under ZFS in Solaris](https://www.thegeekdiary.com/how-to-replace-a-disk-under-zfs-in-solaris/)
1. [Solaris ZFS : How to Create and Manage Mirrored Storage Pools](https://www.thegeekdiary.com/solaris-zfs-how-to-create-and-manage-mirrored-storage-pools/)
1. [How To Increase rpool Size On Solaris 11 (Requires a Reboot)](https://www.thegeekdiary.com/how-to-increase-rpool-size-on-solaris-11-requires-a-reboot/)
1. [How to Configure iSCSI targets on Solaris 10](https://www.thegeekdiary.com/how-to-configure-iscsi-targets-on-a-solaris-10)
1. [How To Use ‘zpool split’ to Split rpool in solaris 11 (x86/x64)](https://www.thegeekdiary.com/how-to-use-zpool-split-to-split-rpool-in-solaris-11-x86x64/)
1. [How to mount the zfs rpool while booted from CD SPARC](https://www.thegeekdiary.com/how-to-mount-the-zfs-rpool-while-booted-from-cd-sparc/)
