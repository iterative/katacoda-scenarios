In the beginning we used `dvc get` to download a DVC data file from a
Git repository. If we want to get an updated copy of that file we have
to rerun the same command again. However if some time has passed, we
might even forget where did we get that file from, or even that it was
downloaded from another project.

A better alternative would be to use `dvc import`.
