One of the main functions of DVC is tracking data files and
directories and keeping their versions. The data files in DS/ML
usually are binary or big, such that Git is not suitable for tracking
them. Here is where DVC comes to rescue. In this scenario we will see
how to use DVC to track data and their versions.

DVC and Git are not exclusive to each-other; DVC is usually integrated
with Git so that while Git keeps track of the code and configuration
files, DVC keeps track of the data. However DVC can also work
independently of Git, and this is how we will use it in this scenario
(for the sake of simplicity, so that we can focus on the basic
features of DVC). In later scenarios we will also see how DVC works
together with Git and how it takes advantage of Git's versioning
features to keep track of the data versions.
