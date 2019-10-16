Sometimes you might want DVC to ignore some files while working with
the project. For example, when working in a workspace directory with a
large number of data files, you might encounter extended execution
time for operations as simple as `dvc status`. In an other case you might
want to omit files or folders unrelated to the project (like `.DS_Store`
on Mac).

To address these scenarios, DVC supports optional `.dvcignore` files,
which have the same syntax and work similarly to `.gitignore` in
Git. They can be placed in the root of the project or inside any
subdirectory, and they contain a pattern on each line. During
execution of commands that traverse directories, DVC will ignore the
matching paths.
