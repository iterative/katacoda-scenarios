How cool would it be to make Git handle arbitrary large files and directories
with the same performance as with small code files? Imagine you can do a git
clone and see data files and ML model files in the workspace. Or do git checkout
and switch to a different version of a 100Gb size file in a less than a second?

The core part of DVC is a few commands that you can run along with Git to track
a large file, ML model or a directory.
