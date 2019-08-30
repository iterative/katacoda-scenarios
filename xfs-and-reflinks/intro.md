Copy-on-Write filesystems have the nice property that it is possible
to "clone" files instantly, by having the new file refer to the old
blocks, and copying (possibly) changed blocks. This both saves time
and space, and can be very beneficial in a lot of situations (for
example when working with big files). In Linux this type of copy is
called "reflink". We will see how to use it on the XFS filesystem.
