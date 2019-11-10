Some teams may prefer using one single shared machine to run their
experiments. This allows them to have better resource utilization such
as the ability to use multiple GPUs, centralize all data storage, etc.

With DVC, you can easily setup shared data storage on the server. This
allows your team to store and share data for your projects
efficiently, and to have almost instantaneous workspace restoration
speed, similar to `git checkout` for your code.

In this example we will see how two different users on the same host
can share data with the help of a local data storage. So, both of the
users and the data storage are located on the same machine and no
remote server or storage is involved.

![](/dvc/courses/examples/diagrams/shared-server.png)
