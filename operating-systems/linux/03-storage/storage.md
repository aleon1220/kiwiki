[Kiwiki Home](/../../)

[Back to Main Page](./readme.md)

# Compute Storage
Hard drives, volumes, SSDs, mounts, filesystem, etc

## Process for Linux + `LVM` + `ext3`

LVM volume group myvg, mounted volume name `uservol1` and disk device in Linux is `/dev/sdf`

Allocate the disk to the VM. (In Amazon Management Console, Create the EBS volume, write down its ID, and allocate it to the instance)
The EC2 instance should have some udev rules for creating the device node. So you should see a new disk in `/dev/sd*`

Log in on the instance and check that the EBS volume is visible,

```bash
fdisk -l /dev/sdf
```

- check the partitions

```bash
cat /proc/partitions
```

- Check the Block ID, Type and label of the system devices

```bash
blkid
```

- Create partition table if needed:

```bash
fdisk /
sfdisk
```

- Initialize LVM

```bash
pvcreate /dev/sdf
```

- Add the disk (physical volume) to the LVM volume group vgextend

```bash
myvg /dev/sdf
```

- Grow the Volume size

```bash
lvextend -L +1024G /dev/myvg/uservol1
```

- Grow the `ext3/ext4` file system

```bash
resize2fs /dev/myvg/uservol1`
```

- Check system info and you should see that the mounted file system now have more space.

```bash
df -h
```

#### View your available disk devices, mount points (if applicable) to help you determine the correct device name to use

```bash
lsblk
```

#### Get information about the devices attached to the instance

```bash
sudo lsblk -f
```

#### Get manufacturer details for the device in a given format

```bash
lsblk -io NAME,TYPE,SIZE,MOUNtPOINT,FSTYPE,MODEL
```

#### Get `UUID` of the device (expensive command)

```bash
sudo blkid $DEVICE_REPORT_PORTAL_DATA | sed -n 's/.*UUID=\"\([^\"]*\)\".*/\1/p'
```

#### Get `UUID` of the device

```bash
DEVICE="/dev/nvme1n1"
# short format flags
sudo blkid -s UUID -o value $DEVICE
```

#### Get `UUID` of the device using long format flags

```bash
sudo blkid --match-tag UUID --output value $DEVICE
```

#### Make an USB bootable with a debian ISO

```bash
USB_DRIVE="/dev/sda"
ISO_PATH="/home/ws/01-inbox/debian/debian-11.0.0-amd64-DVD-1.iso"

sudo umount $USB_DRIVE
sudo dd bs=4M if=$ISO_PATH of=$USB_DRIVE conv=fdatasync status=progress
```

- Output of above in Ubuntu 20.04

```bash
sudo dd bs=4M if=/home/ws/01-inbox/debian/debian-11.0.0-amd64-DVD-1.iso of=/dev/sda conv=fdatasync status=progress
3946840064 bytes (3.9 GB, 3.7 GiB) copied, 328 s, 12.0 MB/s
941+1 records in
941+1 records out
3947823104 bytes (3.9 GB, 3.7 GiB) copied, 596.281 s, 6.6 MB/s
```

#### DMI table decoder

```bash
dmidecode | grep UUID
```

#### Get/set SATA/IDE device parameters

```bash
DEVICE="/dev/nvme1n1"
hdparm -tT --direct $DEVICE
```

#### Get information about a specific device, such as its file system type.  If the output shows simply data, there is no filesystem in the device

```bash
DEVICE_CHECK="/dev/xvdf"*
sudo file -s $DEVICE_CHECK
```

##### Confirm mounted loop device kernel module

```bash
lsmod | grep loop
```

##### Info about mount the loop device kernel module

```bash
modprobe loop
```

#### Show ID of Block devices

```bash
sudo blkid

# Ubuntu
sudo lsblk -o +UUID
```

##### Mount an ISO file as loop device

```bash
mount -o loop -t iso9660 <path/to/iso/file> /media/cdrom
```

#### Mount all filesystems

The file that keeps track of mounted devices is `/etc/fstab`

```bash
sudo mount -a
```
[Back to top](#)

[Kiwiki Home](/../../)