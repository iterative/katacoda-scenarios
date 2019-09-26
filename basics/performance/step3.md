# Use symlinks

The fast and efficient **reflink** copy works only inside the
boundaries of a filesystem. If for some reason the data files and the
cache have to be on different filesystems, a slow and inefficient
normal copy is going to be used.

If this is the case, then we can configure DVC to use **symlinks**
(which work across filesystem boundaries).
