Usually projects have a central data storage, located somewhere on the
cloud, where it can be accessed by all the parties involved in the
project. It helps in sharing the data of the project, intermediate
results, models, etc. among the project members. This is done with the
commands `dvc push` and `dvc pull` (which are similar to `git push`
and `git pull`).

In this example we will assume a central data storage server that can
be accessed through SSH from two different users. For the sake of
example the central Git repository will be located in this server too,
but in general it can be anywhere, it doesn't have to be on the same
server with the DVC data storage.

We will see some configurations and setup that can enable and
facilitate data sharing in such a scenario. However keep in mind that
this is just an example, and other variations in configuration might be
possible, depending on your real situation.
