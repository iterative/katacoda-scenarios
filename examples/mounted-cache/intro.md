> **Prerequisites:** If you haven't already done it, you should study
> first these examples which are closely related:
> - https://katacoda.com/dvc/courses/examples/shared-server
> - https://katacoda.com/dvc/courses/examples/ssh-storage
> - https://katacoda.com/dvc/courses/examples/mounted-storage

In [Mounted DVC
Storage](https://katacoda.com/dvc/courses/examples/mounted-storage) we saw how
to share data through a DVC storage that is located on a NAS:

<p align="center">
<img src="/dvc/courses/examples/mounted-storage/assets/mounted-storage.png">
</p>

In this case we have at least three copies of each data file: one on
the first client, one on the NAS, and one on the second client. Using
deduplicating filesystems cannot optimize this situation because
deduplication does not work across filesystem boundaries.

However in this case we can use another optimization trick: we can
locate the DVC cache of the project on the NAS, and we can configure
the different user projects to use the same DVC cache. We should also
configure each project to use **symlinks** so that there is only one
copy of the data (on the NAS partition) and it is linked from each
project.

<p align="center">
<img src="/dvc/courses/examples/mounted-cache/assets/mounted-cache.png">
</p>

In this example we will see how to share data with the help of a DVC
cache directory that is mounted through SSHFS. We are using it just as
an example, since SSHFS is easy to be used for an interactive
tutorial, however once you understand how it works, it should be easy
to implement it for other types of mounted storages (like NFS, Samba,
etc.).
