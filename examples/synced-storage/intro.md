> **Prerequisites:** If you haven't already done it, you should study
> first these examples which are closely related:
> - https://katacoda.com/dvc/courses/examples/shared-server
> - https://katacoda.com/dvc/courses/examples/ssh-storage

Usually projects have a central data storage, which can be accessed by
all the parties involved in the project. It helps in sharing the data
of the project with the commands `dvc push` and `dvc pull` (which are
similar to `git push` and `git pull`).

However the commands `dvc push` and `dvc pull` support only a few
cloud storage types, like: SSH, S3, GCS, HDFS, etc. while there are
lots of other cloud storages out there (for example look at the ones
supported by [rclone](https://rclone.org/)). Does it mean that we
cannot use these storage types for sharing data with DVC? Not at
all! Using a couple of tricks we can still share DVC data through
them.

In this example we will see how to achieve this with the help of a SSH
storage and `rsync`. Yes, SSH is one of the storage types that is
already supported by DVC, and normally we don't need to do this. But
we are using it just as an example, since SSH is easy to be used for
an interactive tutorial. Once you understand how it works, it should
be easy to implement it for other storage types.

<p align="center">
<img src="/dvc/courses/examples/synced-storage/assets/synced-storage.png">
</p>
