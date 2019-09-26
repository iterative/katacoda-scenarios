DVC is meant to handle big data files and directories, so it is
important that it is optimized for handling them efficiently. DVC
tries to do its best, but sometimes this does not depend only on
DVC. For example DVC tries by default to use **reflink** copy, which
is much faster and more efficient than a normal copy, but this does
not work if the filesystem does not support Copy-on-Write (CoW).

To make DVC more efficient we should make sure that our data and cache
are stored on a filesystem that supports CoW, like XFS, Btrfs, ZFS,
etc. (ext4 does not support it yet). However if this is not the case,
we can still implement some fixes or workarounds. In this lesson we
will see a couple of them.
