> **Prerequisites:** If you haven't already done it, you should study
> first these examples which are closely related:
> - https://katacoda.com/dvc/courses/examples/shared-server
> - https://katacoda.com/dvc/courses/examples/ssh-storage

Usually projects have a central data storage, which can be accessed by
all the parties involved in the project. It helps in sharing the data
of the project with the commands `dvc push` and `dvc pull` (which are
similar to `git push` and `git pull`).

In this example we will see how to share data with the help of a
storage directory that is mounted through SSHFS. Normally we don't
need to do this, since we can [use a SSH remote storage](
https://katacoda.com/dvc/courses/examples/ssh-storage) directly. But
we are using it just as an example, since SSHFS is easy to be used for
an interactive tutorial. Once you understand how it works, it should
be easy to implement it for other types of mounted storages (NFS,
Samba, etc.).

